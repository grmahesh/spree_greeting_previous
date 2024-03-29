Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  
  Spree::Core::Engine.add_routes do
        
        resources :greetings, only: [:index, :show] 
         
        namespace :admin do
          
          get '/search/greetings', to: "search#greetings", as: :search_greetings
          
          resources :greetings do
            resources :greeting_properties do
              collection do
                post :update_positions
              end
            end
=begin      resources :images do
              collection do
                post :update_positions
              end
            end
=end
            member do
              post :clone
              get :stock
            end
            resources :variants do
              collection do
                post :update_positions
              end
            end
            resources :variants_including_master, only: [:update]
          end
          delete '/greeting_properties/:id', to: "greeting_properties#destroy", as: :greeting_property
        end
        
        namespace :api, defaults: { format: 'json' } do
            namespace :v1 do
            
              resources :greetings do
                #resources :images
                resources :variants
                resources :greeting_properties
              end
        
              get '/taxons/greetings', to: 'taxons#greetings', as: :taxon_greetings
            end
        end
    end
  
end
