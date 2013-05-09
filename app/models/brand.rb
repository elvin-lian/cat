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

  def get_pdf_png
    pictures = []
    return pictures unless pdf_hard_path and File.exist?(pdf_hard_path)
    3.times do |i|
      pictures << "/system/pdf/brand/png/#{self.id}_000#{i + 1}.png" if File.exist?("#{png_save_path}#{self.id}_000#{i + 1}.png")
    end
    pictures
  end

  def pdf2png
    return pictures unless pdf_hard_path and File.exist?(pdf_hard_path)

    Dir.mkdir(png_save_path) unless Dir.exist?(png_save_path)
    RGhost::Convert.new(pdf_hard_path).to :png, :multipage => true, :filename => "#{png_save_path}#{self.id}.png", :range => 1..3
  end

  private

  def png_save_path
    Rails.root.to_s + '/public/system/pdf/brand/png/'
  end

  def pdf_hard_path
    Rails.root.to_s + '/public'.to_s + self.pdf.url.to_s
  end

end
