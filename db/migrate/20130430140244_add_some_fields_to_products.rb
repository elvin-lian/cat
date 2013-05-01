class AddSomeFieldsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :price, :string
    add_column :products, :design_inspiration, :text
    add_column :products, :color_pic, :string
  end
end
