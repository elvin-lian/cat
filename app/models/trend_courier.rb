class TrendCourier < ActiveRecord::Base
  attr_accessible :title, :pic, :status

  has_many :products

  validates_presence_of :pic

  mount_uploader :pic, PictureUploader

  def full_pic_url
    if self.pic
      Rails.application.config.action_controller.asset_host + self.pic.url
    end
  end

end
