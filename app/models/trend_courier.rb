class TrendCourier < ActiveRecord::Base
  attr_accessible :title, :pic, :status

  has_many :products

  validates_presence_of :pic

  mount_uploader :pic, PictureUploader

  def simple_json
    {
        pic: self.full_pic_url,
        title: Cat::Tool.nil2n(self.title)
    }
  end

  def full_pic_url
    if self.pic and self.pic.url
      Rails.application.config.action_controller.asset_host + self.pic.url
    else
      ''
    end
  end

end
