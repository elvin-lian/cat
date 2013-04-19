class Suit < ActiveRecord::Base
  attr_accessible :pic, :serial_number, :status, :title

  validates_presence_of :serial_number, :pic
  validates_uniqueness_of :serial_number

  has_and_belongs_to_many :products
  has_and_belongs_to_many :new_products

  mount_uploader :pic, PictureUploader

  def full_pic_url
    if self.pic
      Rails.application.config.action_controller.asset_host + self.pic.url
    end
  end

end
