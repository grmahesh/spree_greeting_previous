class AddMetaTitleToSpreeGreetings < ActiveRecord::Migration
  def change
    change_table :spree_greetings do |t|
      t.string   :meta_title
    end
  end
end
