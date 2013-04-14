class Device < ActiveRecord::Base
  attr_accessible :uid

  validates_presence_of :uid
  validates_uniqueness_of :uid

end
