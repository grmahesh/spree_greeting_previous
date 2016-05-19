Spree::BaseHelper.module_eval do

    def display_price(product_or_variant)
      product_or_variant.
        price_in(current_currency).
        display_price_including_vat_for(current_price_options).
        to_html
    end
    
    def meta_data
      object = instance_variable_get('@'+controller_name.singularize)
      meta = {}

      if object.kind_of? ActiveRecord::Base
        meta[:keywords] = object.meta_keywords if object[:meta_keywords].present?
        meta[:description] = object.meta_description if object[:meta_description].present?
      end

      if meta[:description].blank? && object.kind_of?(Spree::Product)
        meta[:description] = truncate(strip_tags(object.description), length: 160, separator: ' ')
      end
      
      if meta[:description].blank? && object.kind_of?(Spree::Greeting)
        meta[:description] = truncate(strip_tags(object.description), length: 160, separator: ' ')
      end

      meta.reverse_merge!({
        keywords: current_store.meta_keywords,
        description: current_store.meta_description,
      }) if meta[:keywords].blank? or meta[:description].blank?
      meta
    end

    def meta_data_tags
      meta_data.map do |name, content|
        tag('meta', name: name, content: content)
      end.join("\n")
    end

    def method_missing(method_name, *args, &block)
      if image_style = image_style_from_method_name(method_name)
        define_image_method(image_style)
        self.send(method_name, *args)
      else
        super
      end
    end

    def pretty_time(time)
      [I18n.l(time.to_date, format: :long), time.strftime("%l:%M %p")].join(" ")
    end

    def seo_url(taxon)
      return spree.nested_taxons_path(taxon.permalink)
    end

    # human readable list of variant options
    def variant_options(v, options={})
      v.options_text
    end
end
