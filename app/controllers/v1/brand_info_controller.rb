class V1::BrandInfoController < V1::BaseController

  def index
    brand = Brand.last
    if brand.nil?
      re = {
          pdfURL: "",
          updateTime: ""
      }
    else
      re = {
          pdfURL: brand.full_pdf_url,
          updateTime: brand.updated_at.to_s
      }
    end
    render json: {statusCode: 1, response: re}, status: :ok
  end

end