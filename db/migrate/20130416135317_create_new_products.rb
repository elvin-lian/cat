class CreateNewProducts < ActiveRecord::Migration
  def change
    create_table :new_products do |t|
      t.string :name
      t.string :pic
      t.integer :rank, :default => 0
      t.boolean :status, :default => true

      t.timestamps
    end
  end
end
