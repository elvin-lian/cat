class CreateSkins < ActiveRecord::Migration
  def change
    create_table :skins do |t|
      t.string :bg_img
      t.string :brand_info_img
      t.string :product_show_img
      t.string :city_week_img
      t.string :latest_see_img
      t.string :shop_info_img
      t.string :hide_show_btn_img
      t.string :back_img
      t.string :close_img
      t.string :search_img
      t.string :trend_courier_img
      t.string :pro_to_suit_img
      t.string :pro_evaluate_img
      t.string :pro_evaluate_commit_img
      t.string :status, :default => 0
      t.string :name

      t.timestamps
    end
  end
end
