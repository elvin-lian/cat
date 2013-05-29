class AddColorNameToProducts < ActiveRecord::Migration
  def change
    add_column :products, :color_name, :string
  end
end
