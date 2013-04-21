class Product < ActiveRecord::Base
  attr_accessible :color_name, :color_rgb, :description, :serial_number, :trend_courier_id, :status, :title,
                  :category_ids, :suit_ids

  validates_presence_of :serial_number
  validates_uniqueness_of :serial_number

  belongs_to :trend_courier
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :suits
  has_many :product_pictures, :dependent => :destroy
  has_many :product_comments, :dependent => :destroy

end