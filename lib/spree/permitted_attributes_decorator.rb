Spree::PermittedAttributes.module_eval do
    ATTRIBUTES = [
      :address_attributes,
      :checkout_attributes,
      :customer_return_attributes,
      :image_attributes,
      :inventory_unit_attributes,
      :line_item_attributes,
      :option_type_attributes,
      :option_value_attributes,
      :payment_attributes,
      :product_attributes,
      :greeting_attributes,
      :product_properties_attributes,
      :property_attributes,
      :return_authorization_attributes,
      :shipment_attributes,
      :source_attributes,
      :stock_item_attributes,
      :stock_location_attributes,
      :stock_movement_attributes,
      :store_attributes,
      :store_credit_attributes,
      :taxon_attributes,
      :taxonomy_attributes,
      :user_attributes,
      :variant_attributes
    ]

    @@greeting_attributes = [
      :name, :description, :available_on, :discontinue_on, :permalink, :meta_description,
      :meta_keywords, :price, :sku, :deleted_at, :prototype_id,
      :option_values_hash,
      :shipping_category_id, :tax_category_id,
      :cost_currency, :cost_price,
      option_type_ids: [], taxon_ids: []
    ]

    # month / year may be provided by some sources, or others may elect to use one field
    
    @@variant_attributes = [
      :name, :presentation, :cost_price, :discontinue_on, :lock_version,
      :position, :track_inventory,
      :product_id, :product, :option_values_attributes, :price,
      :greeting_id, :greeting,
      :weight, :height, :width, :depth, :sku, :cost_currency,
      options: [:name, :value], option_value_ids: []
    ]
  end
end
