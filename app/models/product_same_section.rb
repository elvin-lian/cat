class ProductSameSection < ActiveRecord::Base
  attr_accessible :p_id, :product_id

  validates_presence_of :p_id
  validates_presence_of :product_id

  validates_uniqueness_of :product_id, scope: :p_id

  belongs_to :product

end
