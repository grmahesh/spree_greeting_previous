Spree::Order.class_eval do
    
    has_many :greetings, through: :variants

    # Returns the address for taxation based on configuration
    
   
    # This method enables extensions to participate in the
    # "Are these line items equal" decision.
    #
    # When adding to cart, an extension would send something like:
    # params[:greeting_customizations]={...}
    #
    # and would provide:
    #
    # def greeting_customizations_match
=begin    def line_item_options_match(line_item, options)
      return true unless options

      self.line_item_comparison_hooks.all? { |hook|
        self.send(hook, line_item, options)
      }
    end
=end
    # Creates new tax charges if there are any applicable rates. If prices already
    # include taxes then price adjustments are created instead.

end
