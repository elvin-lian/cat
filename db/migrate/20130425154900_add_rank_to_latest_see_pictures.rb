class AddRankToLatestSeePictures < ActiveRecord::Migration
  def change
    add_column :latest_see_pictures, :rank, :integer, :default => 20
    add_index :latest_see_pictures, :rank
  end
end
