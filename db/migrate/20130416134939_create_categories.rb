class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :pic
      t.integer :rank, :default => 0
      t.boolean :status, :default => true

      t.timestamps
    end

    add_index :categories, :status
    add_index :categories, :rank
  end
end
