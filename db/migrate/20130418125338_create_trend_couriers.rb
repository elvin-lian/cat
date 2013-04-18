class CreateTrendCouriers < ActiveRecord::Migration
  def change
    create_table :trend_couriers do |t|
      t.string :title, :limit => 64
      t.string :pic
      t.boolean :status

      t.timestamps
    end

    add_index :trend_couriers, :status
  end
end
