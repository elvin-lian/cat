class CreateNewProductsSuits < ActiveRecord::Migration
  def change
    create_table :new_products_suits do |t|
      t.integer :suit_id
      t.integer :new_product_id
    end

    add_index :new_products_suits, :suit_id
    add_index :new_products_suits, :new_product_id
  end
end
