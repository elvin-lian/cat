class Device < ActiveRecord::Base
  attr_accessible :uid

  validates_presence_of :uid
  validates_uniqueness_of :uid

  has_many :product_comments, :dependent => :destroy
end
