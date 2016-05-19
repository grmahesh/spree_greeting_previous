module Spree
  class GreetingDuplicator
    attr_accessor :greeting

    #@@clone_images_default = true
    #mattr_accessor :clone_images_default

    def initialize(greeting)
      @greeting = greeting
    end

    def duplicate
      new_greeting = duplicate_greeting

      # don't dup the actual variants, just the characterising types
      new_greeting.option_types = greeting.option_types if greeting.has_variants?

      # allow site to do some customization
      new_greeting.send(:duplicate_extra, greeting) if new_greeting.respond_to?(:duplicate_extra)
      new_greeting.save!
      new_greeting
    end

    protected

    def duplicate_greeting
      greeting.dup.tap do |new_greeting|
        new_greeting.name = "COPY OF #{greeting.name}"
        new_greeting.taxons = greeting.taxons
        new_greeting.created_at = nil
        new_greeting.deleted_at = nil
        new_greeting.updated_at = nil
        new_greeting.master = duplicate_master
        new_greeting.variants = greeting.variants.map { |variant| duplicate_variant variant }
      end
    end

    def duplicate_master
      master = greeting.master
      master.dup.tap do |new_master|
        new_master.sku = "COPY OF #{master.sku}"
        new_master.deleted_at = nil
        new_master.price = master.price
        new_master.currency = master.currency
      end
    end

    def duplicate_variant(variant)
      new_variant = variant.dup
      new_variant.sku = "COPY OF #{new_variant.sku}"
      new_variant.deleted_at = nil
      new_variant.option_values = variant.option_values.map { |option_value| option_value}
      new_variant
    end
=begin    
    def duplicate_image(image)
      new_image = image.dup
      new_image.assign_attributes(:attachment => image.attachment.clone)
      new_image
    end

    def reset_properties
      product.product_properties.map do |prop|
        prop.dup.tap do |new_prop|
          new_prop.created_at = nil
          new_prop.updated_at = nil
        end
      end
    end
=end   
  end
end
