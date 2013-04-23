class ProductPicture < ActiveRecord::Base
  attr_accessible :pic, :product_id

  validates_presence_of :pic, :product_id

  belongs_to :product

  mount_uploader :pic, PictureUploader

  def full_pic_url
    if self.pic
      Rails.application.config.action_controller.asset_host + self.pic.url
    else
      ''
    end
  end

  def to_jq_upload
    {
        name: read_attribute(:pic),
        size: self.pic.size,
        url: self.pic.url,
        thumbnail_url: self.pic.thumb.url,
        delete_url: "/admin/products/#{self.product_id}/pictures/#{self.id}",
        picture_id: self.id,
        delete_type: "DELETE"
    }
  end

end
