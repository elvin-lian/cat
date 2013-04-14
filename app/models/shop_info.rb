class ShopInfo < ActiveRecord::Base
  attr_accessible :pic

  validates_presence_of :pic

  mount_uploader :pic, PictureUploader

  def to_jq_upload
    {
        name: read_attribute(:pic),
        size: self.pic.size,
        url: self.pic.url,
        thumbnail_url: self.pic.thumb.url,
        delete_url: "/admin/shop_infos/#{self.id}",
        picture_id: self.id,
        delete_type: "DELETE"
    }
  end

  def full_pic_url
    if self.pic
      Rails.application.config.action_controller.asset_host + self.pic.url
    end
  end

end
