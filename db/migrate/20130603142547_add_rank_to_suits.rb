class AddRankToSuits < ActiveRecord::Migration
  def change
    add_column :suits, :rank, :integer, :default => 0
    add_index :suits, :rank
  end
end
