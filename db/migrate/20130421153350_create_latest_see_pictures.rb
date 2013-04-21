class CreateLatestSeePictures < ActiveRecord::Migration
  def change
    create_table :latest_see_pictures do |t|
      t.integer :latest_see_id
      t.string :title
      t.string :pic

      t.timestamps
    end

    add_index :latest_see_pictures, :latest_see_id
  end
end
