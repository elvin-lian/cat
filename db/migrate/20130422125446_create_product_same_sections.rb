class CreateProductSameSections < ActiveRecord::Migration
  def change
    create_table :product_same_sections do |t|
      t.integer :product_id
      t.integer :p_id
    end

    add_index :product_same_sections, :product_id
    add_index :product_same_sections, :p_id
  end
end

