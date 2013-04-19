class Brand < ActiveRecord::Base
  attr_accessible :pdf

  def full_pdf_url
    ''
  end
end
