class AddRankToProducts < ActiveRecord::Migration
  def change
    add_column :products, :rank, :integer, :default => 0
    add_index :products, :rank
  end
end
