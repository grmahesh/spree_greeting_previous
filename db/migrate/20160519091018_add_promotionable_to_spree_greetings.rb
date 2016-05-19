class AddPromotionableToSpreeGreetings < ActiveRecord::Migration
  def change
    add_column :spree_greetings, :promotionable, :boolean, default: true
  end
end
