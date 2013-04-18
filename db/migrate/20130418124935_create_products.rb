class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :serial_number, :limit => 100
      t.string :title, :limit => 100
      t.text :description, :limit => 1000
      t.string :color_name, :limit => 32
      t.string :color_rgb, :limit => 32
      t.boolean :status, :default => 1
      t.integer :trend_courier_id

      t.timestamps
    end

    add_index :products, :status
  end
end
