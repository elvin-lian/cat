# encoding: utf-8
class Admin::BrandsController < Admin::BaseController

  load_and_authorize_resource

  def index
    @brand = Brand.last
    @brand = Brand.new if @brand.nil?
  end

  def create
    @brand = Brand.new(params[:brand])
    if @brand.save
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