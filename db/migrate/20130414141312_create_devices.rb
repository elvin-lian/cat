class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :uid, length: 64

      t.timestamps
    end

    add_index :devices, :uid, length: {:uid => 16}
  end
end
