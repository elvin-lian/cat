class CreateSkins < ActiveRecord::Migration
  def change
    create_table :skins do |t|
      t.string :category_pro_bg
      t.string :l_category_pro_bg
      t.string :suits_list_bg
      t.string :l_suits_list_bg
      t.string :suit_bg
      t.string :l_suit_bg
      t.string :pro_list_bg
      t.string :l_pro_list_bg
      t.string :pro_bg
      t.string :l_pro_bg
      t.string :other_bg
      t.string :l_other_bg
      t.string :tool_show_hide_btn
      t.string :l_tool_show_hide_btn
      t.string :tool_home_btn
      t.string :l_tool_home_btn
      t.string :search_btn
      t.string :l_search_btn
      t.string :close_btn
      t.string :l_close_btn
      t.string :close_to_home_btn
      t.string :l_close_to_home_btn
      t.string :left_arrow_btn
      t.string :l_left_arrow_btn
      t.string :right_arrow_btn
      t.string :l_right_arrow_btn
      t.string :tool_bg_image
      t.string :l_tool_bg_image
      t.string :brand_info_btn
      t.string :l_brand_info_btn
      t.string :pro_show_btn
      t.string :l_pro_show_btn
      t.string :city_week_btn
      t.string :l_city_week_btn
      t.string :lastest_see_btn
      t.string :l_lastest_see_btn
      t.string :shop_info_btn
      t.string :l_shop_info_btn
      t.string :back_btn
      t.string :l_back_btn
      t.string :trend_courier_btn
      t.string :l_trend_courier_btn
      t.string :pro_to_suit_btn
      t.string :l_pro_to_suit_btn
      t.string :pro_evaluate_btn
      t.string :l_pro_evaluate_btn
      t.string :pro_text_bg
      t.string :l_pro_text_bg
      t.string :title
      t.boolean :status, :default => 0
      t.timestamps
    end
  end
end
