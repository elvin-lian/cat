class AddRankToProductPictures < ActiveRecord::Migration
  def change
    add_column :product_pictures, :rank, :integer, :default => 10
    add_index :product_pictures, :rank
  end
end
