class CityWeekly < ActiveRecord::Base
  attr_accessible :description, :pic, :status, :title

  mount_uploader :pic, PictureUploader


  def full_pic_url
    if self.pic and self.pic.url
      Rails.application.config.action_controller.asset_host + self.pic.url
    else
      ''
    end
  end

  def simple_json
    {
        contentTitle: Cat::Tool.nil2n(self.title),
        contentURL: full_pic_url,
        contentText: Cat::Tool.nil2n(self.description)
    }
  end

end
