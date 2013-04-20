class Brand < ActiveRecord::Base
  attr_accessible :pdf

  mount_uploader :pdf, PdfUploader

  def full_pdf_url
    if self.pdf and self.pdf.url
      Rails.application.config.action_controller.asset_host + self.pdf.url
    else
      ''
    end
  end

end
