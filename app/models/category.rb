class Category < ActiveRecord::Base
  attr_accessible :name, :pic, :rank, :status

  validates_presence_of :name
  validates_uniqueness_of :name


  mount_uploader :pic, PictureUploader

  def full_pic_url
    if self.pic
      Rails.application.config.action_controller.asset_host + self.pic.url
    end
  end

end
