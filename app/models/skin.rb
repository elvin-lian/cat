class Skin < ActiveRecord::Base
  attr_accessible :back_img, :bg_img, :brand_info_img, :city_week_img, :close_img, :hide_show_btn_img, :latest_see_img,
                  :pro_evaluate_commit_img, :pro_evaluate_img, :pro_to_suit_img, :product_show_img, :search_img,
                  :shop_info_img, :trend_courier_img, :status, :name


  mount_uploader :back_img, PictureUploader
  mount_uploader :bg_img, PictureUploader
  mount_uploader :brand_info_img, PictureUploader
  mount_uploader :city_week_img, PictureUploader
  mount_uploader :close_img, PictureUploader
  mount_uploader :hide_show_btn_img, PictureUploader
  mount_uploader :latest_see_img, PictureUploader
  mount_uploader :pro_evaluate_commit_img, PictureUploader
  mount_uploader :pro_evaluate_img, PictureUploader
  mount_uploader :pro_to_suit_img, PictureUploader
  mount_uploader :product_show_img, PictureUploader
  mount_uploader :search_img, PictureUploader
  mount_uploader :shop_info_img, PictureUploader
  mount_uploader :trend_courier_img, PictureUploader

end
