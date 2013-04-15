class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :pic
      t.boolean :status, :default => 0

      t.timestamps
    end
  end
end
