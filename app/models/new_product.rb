class NewProduct < ActiveRecord::Base
  attr_accessible :name, :pic, :rank, :status

  validates_presence_of :name
  validates_uniqueness_of :name

  has_and_belongs_to_many :suits

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
        lastestProductID: self.id.to_s,
        lastestProductName: self.name,
        lastestProductURL: full_pic_url
    }
  end

end
