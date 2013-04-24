class Suit < ActiveRecord::Base
  attr_accessible :pic, :serial_number, :status, :title

  validates_presence_of :serial_number
  validates_uniqueness_of :serial_number

  has_and_belongs_to_many :products
  has_and_belongs_to_many :new_products

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
        suitID: self.id.to_s,
        suitTitle: self.title.nil? ? '' : self.title,
        suitSerialNumber: self.serial_number,
        createTime: self.created_at.to_s,
        updateTime: self.updated_at.to_s,
        suitImageURL: full_pic_url,
        subProList: sub_products
    }
  end

  def sub_products
    products = self.products.where('status = 1').order('id DESC').includes(:categories)
    res = []
    products.each do |product|
      cat_id = ''
      if( cat = product.categories.first)
        cat_id = cat.id.to_s
      end

      res << {
          productID: product.id.to_s,
          categoryProID: cat_id
      }
    end
    res
  end

end
