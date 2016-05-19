Spree::ShippingCategory.class_eval do
    
      has_many :products, inverse_of: :shipping_category
    
end
