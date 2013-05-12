# encoding: utf-8
class Skin < ActiveRecord::Base
  attr_accessible :back_btn, :brand_info_btn, :category_pro_bg, :city_week_btn, :close_btn, :close_to_home_btn,
                  :lastest_see_btn, :left_arrow_btn, :other_bg, :pro_bg, :pro_evaluate_btn, :pro_list_bg, :pro_show_btn,
                  :pro_text_bg, :pro_to_suit_btn, :right_arrow_btn, :search_btn, :shop_info_btn, :suit_bg,
                  :suits_list_bg, :tool_bg_image, :tool_home_btn, :tool_show_hide_btn, :trend_courier_btn,

                  :l_back_btn, :l_brand_info_btn, :l_category_pro_bg, :l_city_week_btn, :l_close_btn, :l_close_to_home_btn,
                  :l_lastest_see_btn, :l_left_arrow_btn, :l_other_bg, :l_pro_bg, :l_pro_evaluate_btn, :l_pro_list_bg, :l_pro_show_btn,
                  :l_pro_text_bg, :l_pro_to_suit_btn, :l_right_arrow_btn, :l_search_btn, :l_shop_info_btn, :l_suit_bg,
                  :l_suits_list_bg, :l_tool_bg_image, :l_tool_home_btn, :l_tool_show_hide_btn, :l_trend_courier_btn,

                  :status, :title

  mount_uploader :category_pro_bg, PictureUploader
  mount_uploader :suits_list_bg, PictureUploader
  mount_uploader :suit_bg, PictureUploader
  mount_uploader :pro_list_bg, PictureUploader
  mount_uploader :pro_bg, PictureUploader
  mount_uploader :other_bg, PictureUploader
  mount_uploader :tool_show_hide_btn, PictureUploader
  mount_uploader :tool_home_btn, PictureUploader
  mount_uploader :search_btn, PictureUploader
  mount_uploader :close_btn, PictureUploader
  mount_uploader :close_to_home_btn, PictureUploader
  mount_uploader :left_arrow_btn, PictureUploader
  mount_uploader :right_arrow_btn, PictureUploader
  mount_uploader :tool_bg_image, PictureUploader
  mount_uploader :brand_info_btn, PictureUploader
  mount_uploader :pro_show_btn, PictureUploader
  mount_uploader :city_week_btn, PictureUploader
  mount_uploader :lastest_see_btn, PictureUploader
  mount_uploader :shop_info_btn, PictureUploader
  mount_uploader :back_btn, PictureUploader
  mount_uploader :trend_courier_btn, PictureUploader
  mount_uploader :pro_to_suit_btn, PictureUploader
  mount_uploader :pro_evaluate_btn, PictureUploader
  mount_uploader :pro_text_bg, PictureUploader
  mount_uploader :l_category_pro_bg, PictureUploader
  mount_uploader :l_suits_list_bg, PictureUploader
  mount_uploader :l_suit_bg, PictureUploader
  mount_uploader :l_pro_list_bg, PictureUploader
  mount_uploader :l_pro_bg, PictureUploader
  mount_uploader :l_other_bg, PictureUploader
  mount_uploader :l_tool_show_hide_btn, PictureUploader
  mount_uploader :l_tool_home_btn, PictureUploader
  mount_uploader :l_search_btn, PictureUploader
  mount_uploader :l_close_btn, PictureUploader
  mount_uploader :l_close_to_home_btn, PictureUploader
  mount_uploader :l_left_arrow_btn, PictureUploader
  mount_uploader :l_right_arrow_btn, PictureUploader
  mount_uploader :l_tool_bg_image, PictureUploader
  mount_uploader :l_brand_info_btn, PictureUploader
  mount_uploader :l_pro_show_btn, PictureUploader
  mount_uploader :l_city_week_btn, PictureUploader
  mount_uploader :l_lastest_see_btn, PictureUploader
  mount_uploader :l_shop_info_btn, PictureUploader
  mount_uploader :l_back_btn, PictureUploader
  mount_uploader :l_trend_courier_btn, PictureUploader
  mount_uploader :l_pro_to_suit_btn, PictureUploader
  mount_uploader :l_pro_evaluate_btn, PictureUploader
  mount_uploader :l_pro_text_bg, PictureUploader

  def self.non_pic_fields
    %w(id created_at updated_at status title)
  end

  def self.pic_attr
    {
        '首页' => %w(tool_bg_image brand_info_btn pro_show_btn city_week_btn lastest_see_btn shop_info_btn tool_show_hide_btn),
        '背景图' => %w(category_pro_bg suits_list_bg pro_list_bg suit_bg pro_bg other_bg),
        '都市周报' => %w(tool_home_btn close_btn),
        '搭配浏览' => %w(search_btn close_to_home_btn back_btn),
        '品牌咨询' => %w(left_arrow_btn right_arrow_btn),
        '单品展示' => %w(trend_courier_btn pro_to_suit_btn pro_evaluate_btn pro_text_bg)
    }
  end

  def simple_json
    res = {
        skinModelID: self.id.to_s,
        createTime: self.created_at.to_s,
        updateTime: self.updated_at.to_s
    }

    Skin.attribute_names.each do |name|
      unless name.in?(Skin.non_pic_fields)
        res["skin#{name.camelize}URL"] = fill_pic_url(name)
      end
    end

    res
  end

  def fill_pic_url field_name
    return '' if field_name.in?(Skin.non_pic_fields)
    obj = self.send(field_name)
    if obj and obj.url
      Rails.application.config.action_controller.asset_host + obj.url
    else
      ''
    end
  end

  def fill_thumb_pic_url field_name
    return '' if field_name.in?(Skin.non_pic_fields)
    obj = self.send(field_name)
    if obj and obj.url
      Rails.application.config.action_controller.asset_host + obj.thumb.url
    else
      ''
    end
  end

end
