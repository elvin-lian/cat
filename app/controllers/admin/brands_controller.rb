# encoding: utf-8
class Admin::BrandsController < Admin::BaseController

  load_and_authorize_resource

  def index
    @brand = Brand.last
    @brand = Brand.new if @brand.nil?
    @preview_pictures = @brand.get_pdf_png
  end

  def create
    @brand = Brand.new(params[:brand])
    if @brand.save
      @brand.pdf2png
      respond_to do |format|
        format.html {
          update_successfully
          redirect_to action: :index
        }
        format.json {
          render :json => {status: 1, message: '上传成功', updated_at: @brand.updated_at.localtime.strftime('%Y-%m-%d %H:%M:%S'), link: @brand.full_pdf_url}.as_json, status: :ok
        }
      end
    else
      respond_to do |format|
        format.html {
          fail_to_update
          redirect_to action: :index
        }
        format.json {
          render :json => {status: 0, message: '上传失败'}, :status => :ok
        }
      end
    end
  end

  def update
    @brand = Brand.find_by_id(params[:id])
    if @brand.update_attributes(params[:brand])
      @brand.pdf2png
      respond_to do |format|
        format.html {
          update_successfully
          redirect_to action: :index
        }
        format.json {
          render :json => {status: 1, message: '上传成功', updated_at: @brand.updated_at.localtime.strftime('%Y-%m-%d %H:%M:%S'), link: @brand.full_pdf_url}.as_json, status: :ok
        }
      end
    else
      respond_to do |format|
        format.html {
          fail_to_update
          redirect_to action: :index
        }
        format.json {
          render :json => {status: 0, message: '上传失败'}, :status => :ok
        }
      end
    end
  end

  def destroy
    @brand = Brand.find_by_id(params[:id])
    if @brand.destroy
      destroy_successfully
    else
      fail_to_destroy
    end
    redirect_to action: :index
  end

end