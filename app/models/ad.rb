class Ad < ActiveRecord::Base
  attr_accessible :pic, :status

  validates_presence_of :pic

  mount_uploader :pic, PictureUploader

  def full_pic_url
    if self.pic
      Rails.application.config.action_controller.asset_host + self.pic.url
    end
  end

end