class ProductPicture < ActiveRecord::Base
  attr_accessible :pic, :product_id

  validates_presence_of :pic, :product_id

  belongs_to :product

  mount_uploader :pic, PictureUploader

  def full_pic_url
    if self.pic
      Rails.application.config.action_controller.asset_host + self.pic.url
    end
  end

end
