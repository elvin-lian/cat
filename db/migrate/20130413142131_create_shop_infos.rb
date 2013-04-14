class CreateShopInfos < ActiveRecord::Migration
  def change
    create_table :shop_infos do |t|
      t.string :pic

      t.timestamps
    end
  end
end
