class AddPositionsToClassifications < ActiveRecord::Migration
 def change
   add_column :spree_greetings_taxons, :position, :integer
 end
end
