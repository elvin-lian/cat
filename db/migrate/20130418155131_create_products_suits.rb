class CreateProductsSuits < ActiveRecord::Migration
  def change
    create_table :products_suits do |t|
      t.integer :product_id
      t.integer :suit_id
    end

    add_index :products_suits, :suit_id
    add_index :products_suits, :product_id
  end
end
