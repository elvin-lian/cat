class CreateSuits < ActiveRecord::Migration
  def change
    create_table :suits do |t|
      t.string :title, :limit => 64
      t.string :serial_number, :limit => 100
      t.string :pic
      t.boolean :status, :default => 1

      t.timestamps
    end

    add_index :suits, :status
  end
end
