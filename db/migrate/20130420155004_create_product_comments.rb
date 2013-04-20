class CreateProductComments < ActiveRecord::Migration
  def change
    create_table :product_comments do |t|
      t.integer :product_id
      t.integer :device_id
      t.integer :price_score, :limit => 1
      t.integer :design_score, :limit => 1
      t.integer :fabric_score, :limit => 1
      t.boolean :status, :default => 1

      t.timestamps
    end
    add_index :product_comments, :product_id
    add_index :product_comments, :status
  end
end
