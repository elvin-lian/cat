class CreateProductPictures < ActiveRecord::Migration
  def change
    create_table :product_pictures do |t|
      t.string :pic
      t.integer :product_id

      t.timestamps
    end
  end
end
