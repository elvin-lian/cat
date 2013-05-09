# encoding: utf-8
class Category < ActiveRecord::Base
  attr_accessible :name, :pic, :rank, :status, :parent_category

  validates_presence_of :name
  validates_uniqueness_of :name

  has_and_belongs_to_many :products

  mount_uploader :pic, PictureUploader

  def self.parent_categories
    {
        '上装' => 1,
        '下装' => 2,
        '套装' => 3,
        '鞋子' => 4,
        '配饰' => 5
    }
  end

  def full_pic_url
    if self.pic and self.pic.url
      Rails.application.config.action_controller.asset_host + self.pic.url
    else
      ''
    end
  end

  def parent_category_name
    res = ''
    Category.parent_categories.map do |name, id|
      if self.parent_category == id
        res = name
        break
      end
    end
    res
  end

  def simple_json
    {
        categoryProductID: self.id.to_s,
        categoryProductName: self.name,
        categoryProductURL: full_pic_url,
        categoryParentProductID: self.parent_category.to_s,
        categoryParentProductName: self.parent_category_name
    }
  end

end
