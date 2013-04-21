class CreateLatestSees < ActiveRecord::Migration
  def change
    create_table :latest_sees do |t|
      t.string :title
      t.boolean :status, :default => 0

      t.timestamps
    end
  end
end
