class LatestSee < ActiveRecord::Base
  attr_accessible :status, :title

  validates_presence_of :title

  has_many :latest_see_pictures

  def simple_json
    res = []
    self.latest_see_pictures.order('rank ASC, id ASC').each do |pic|
      res << pic.full_pic_url
    end
    res
  end
end
