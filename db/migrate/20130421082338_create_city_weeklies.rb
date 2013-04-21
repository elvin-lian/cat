class CreateCityWeeklies < ActiveRecord::Migration
  def change
    create_table :city_weeklies do |t|
      t.string :title, :limit => 100
      t.string :pic, :limit => 100
      t.text :description
      t.boolean :status, :default => 0

      t.timestamps
    end
  end
end
