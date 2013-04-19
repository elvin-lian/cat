class Ad < ActiveRecord::Base
  attr_accessible :pic, :status

  #validates_presence_of :pic

  mount_uploader :pic, PictureUploader

  def full_pic_url
    if self.pic and self.pic.url
      Rails.application.config.action_controller.asset_host + self.pic.url
    else
      ''
    end
  end

  def simple_as_json
    {
        appHomeAdsImageURL: self.full_pic_url,
        updateTime: self.updated_at.to_s
    }
  end

end