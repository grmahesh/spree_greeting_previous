Spree::Core::Search::Base.class_eval do
        
        def retrieve_greetings
          @greetings = get_base_scopes
          curr_page = page || 1

          unless Spree::Config.show_greetings_without_price
            @greetings = @greetings.where("spree_prices.amount IS NOT NULL").
                                  where("spree_prices.currency" => current_currency)
          end
          @greetings = @greetings.page(curr_page).per(per_page)
        end

        protected
          def get_base_scope
            base_scope = Spree::Product.spree_base_scopes.active
            base_scope = base_scope.in_taxon(taxon) unless taxon.blank?
            base_scope = get_products_conditions_for(base_scope, keywords)
            base_scope = add_search_scopes(base_scope)
            base_scope = add_eagerload_scopes(base_scope)
            base_scope
          end
          
          def get_base_scopes
            base_scope = Spree::Greeting.spree_base_scopes.active
            base_scope = base_scope.in_taxon(taxon) unless taxon.blank?
            base_scope = get_greetings_conditions_for(base_scope, keywords)
            base_scope = add_search_scopes(base_scope)
            base_scope = add_eagerload_scopes(base_scope)
            base_scope
          end 

          def add_search_scopes(base_scope)
            search.each do |name, scope_attribute|
              scope_name = name.to_sym
              if base_scope.respond_to?(:search_scopes) && base_scope.search_scopes.include?(scope_name.to_sym)
                base_scope = base_scope.send(scope_name, *scope_attribute)
              else
                base_scope = base_scope.merge(Spree::Product.ransack({scope_name => scope_attribute}).result)
                base_scope = base_scope.merge(Spree::Greeting.ransack({scope_name => scope_attribute}).result)
              end
            end if search.is_a?(Hash)
            base_scope
          end
          
          def get_greetings_conditions_for(base_scope, query)
            unless query.blank?
              base_scope = base_scope.like_any([:name, :description], query.split)
            end
            base_scope
          end

end
