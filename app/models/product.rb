class Product < ActiveRecord::Base
  attr_accessible :color_name, :color_rgb, :description, :serial_number, :trend_courier_id, :status, :title,
                  :category_ids, :suit_ids, :sub_title, :is_top

  validates_presence_of :serial_number
  validates_uniqueness_of :serial_number

  belongs_to :trend_courier
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :suits
  has_many :product_pictures, :dependent => :destroy
  has_many :product_comments, :dependent => :destroy

  has_many :product_same_sections, :dependent => :destroy

  before_destroy :clean_same_section

  def simple_json
    {
        proID: self.id.to_s,
        proSerialNumber: self.serial_number,
        proTitle: Cat::Tool.nil2n(self.title),
        proSubTitle: Cat::Tool.nil2n(self.sub_title),
        proIsTop: self.is_top? ? 1: 0,
        createTime: self.created_at.to_s,
        updateTime: self.updated_at.to_s,
        proExplainText: Cat::Tool.nil2n(self.description),
        proColorName: Cat::Tool.nil2n(self.color_name),
        proColorRGB: Cat::Tool.nil2n(self.color_rgb),
        proTrendCourierID: self.trend_courier_id.to_s,
        proTrendCourierUrl: self.trend_courier ? self.trend_courier.full_pic_url : '',
        proImageURLArray: picture_urls
    }
  end

  def picture_urls
    res = []
    self.product_pictures.order('id ASC').each do |pic|
      res << pic.full_pic_url
    end
    res
  end

  def same_sections
    res = []
    ProductSameSection.where(p_id: self.id).order('id ASC').each do |section|
      res << section.product.simple_json
    end
    res
  end

  private

  def clean_same_section
    ProductSameSection.destroy_all(p_id: self.id)
  end
end
