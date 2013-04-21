class LatestSeePicture < ActiveRecord::Base
  attr_accessible :latest_see_id, :pic, :title

  belongs_to :latest_see

  mount_uploader :pic, PictureUploader

  def full_pic_url
    if self.pic
      Rails.application.config.action_controller.asset_host + self.pic.url
    else
      ''
    end
  end

end
