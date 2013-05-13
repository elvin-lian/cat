class ProductPicture < ActiveRecord::Base
  attr_accessible :pic, :product_id, :rank

  validates_presence_of :pic, :product_id

  belongs_to :product

  mount_uploader :pic, PictureUploader

  def full_pic_url
    if self.pic and self.pic.url
      Rails.application.config.action_controller.asset_host + self.pic.url
    else
      ''
    end
  end

  def thumb_full_pic_url
    if self.pic and self.pic.url
      Rails.application.config.action_controller.asset_host + self.pic.thumb.url
    else
      ''
    end
  end

  def to_jq_upload
    {
        id: self.id,
        rank: self.rank,
        name: read_attribute(:pic),
        created_at: self.created_at.localtime.strftime('%Y-%m-%d %H:%M'),
        size: self.pic.size,
        url: self.pic.url,
        thumbnail_url: self.pic.thumb.url,
        delete_url: "/admin/products/#{self.product_id}/pictures/#{self.id}",
        picture_id: self.id,
        delete_type: "DELETE"
    }
  end

end
