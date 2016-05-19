module Spree
  module Core
    module Importer
      class Greeting
        attr_reader :greeting, :greeting_attrs, :variants_attrs, :options_attrs

        def initialize(greeting, greeting_params, options = {})
          @greeting = greeting || Spree::Greeting.new(greeting_params)

          @greeting_attrs = greeting_params
          @variants_attrs = options[:variants_attrs] || []
          @options_attrs = options[:options_attrs] || []
        end

        def create
          if greeting.save
            variants_attrs.each do |variant_attribute|
              # make sure the greeting is assigned before the options=
              greeting.variants.create({ greeting: greeting }.merge(variant_attribute))
            end

            set_up_options
          end

          greeting
        end

        def update
          if greeting.update_attributes(greeting_attrs)
            variants_attrs.each do |variant_attribute|
              # update the variant if the id is present in the payload
              if variant_attribute['id'].present?
                greeting.variants.find(variant_attribute['id'].to_i).update_attributes(variant_attribute)
              else
                # make sure the greeting is assigned before the options=
                greeting.variants.create({ greeting: greeting }.merge(variant_attribute))
              end
            end

            set_up_options
          end

          greeting
        end

        private
          def set_up_options
            options_attrs.each do |name|
              option_type = Spree::OptionType.where(name: name).first_or_initialize do |option_type|
                option_type.presentation = name
                option_type.save!
              end

              unless greeting.option_types.include?(option_type)
                greeting.option_types << option_type
              end
            end
          end
      end
    end
  end
end
