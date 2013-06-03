class Suit < ActiveRecord::Base
  attr_accessible :pic, :serial_number, :status, :title, :new_product_ids, :rank

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
        suitRank: self.rank.to_i,
        createTime: self.created_at.to_s,
        updateTime: self.updated_at.to_s,
        suitImageURL: full_pic_url,
        subProList: sub_products
    }
  end

  def sub_products
    products = self.products.where('status = 1').order('is_top DESC, id DESC').limit(20).includes(:categories)
    res = []
    products.each do |product|
      tmp = {
          productID: product.id.to_s,
          proSuitCategoryID: product.suit_category.to_s,
          proSuitCategoryName: product.suit_category_name,
          categoryProID: '',
          categoryProductURL: '',
          categoryProductName: '',
          categoryParentProductName: ''
      }

      if (cat = product.categories.first)
          tmp[:categoryProID] = cat.id.to_s
          tmp[:categoryProductURL] = cat.full_pic_url
          tmp[:categoryProductName] = Cat::Tool.nil2n(cat.name)
          tmp[:categoryParentProductName] = cat.parent_category_name
      end

      res << tmp
    end
    res
  end

end
