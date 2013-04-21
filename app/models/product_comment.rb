class ProductComment < ActiveRecord::Base
  attr_accessible :design_score, :device_id, :fabric_score, :price_score, :product_id, :status

  belongs_to :product
  belongs_to :device

  validates_presence_of :product_id
end
