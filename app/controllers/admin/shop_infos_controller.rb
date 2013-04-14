# encoding: utf-8
class Admin::ShopInfosController < Admin::BaseController

  load_and_authorize_resource

  def index
    @shop_info = ShopInfo.last
    @shop_info = ShopInfo.new if @shop_info.nil?
  end

  def create
    #p_attr = {}
    #p_attr[:pic] = params[:files].first if params[:files].class == Array
    @shop_info = ShopInfo.new(params[:shop_info])
    if @shop_info.save
      respond_to do |format|
        format.html {
          #render :json => {files: [@shop_info.to_jq_upload]}.as_json,
          #       :content_type => 'text/html',
          #       :layout => false
          redirect_to action: :index
        }
        format.json {
          render :json => {files: [@shop_info.to_jq_upload]}.as_json, status: :ok
        }
      end
    else
      respond_to do |format|
        format.html {
          flash[:error] = '上传失败'
          redirect_to action: :index
        }
        format.json {
          render :json => [], :status => :ok
        }
      end
    end
  end

  def update
    @shop_info = ShopInfo.find_by_id(params[:id])
    if @shop_info.update_attributes(params[:shop_info])
      update_successfully
    else
      fail_to_update
    end

    respond_to do |format|
      format.html {
        redirect_to action: :index
      }
      format.json {
        render :json => [], :status => :ok
      }
    end
  end

  def destroy
    @shop_info = ShopInfo.find_by_id(params[:id])
    if @shop_info.destroy
      destroy_successfully
    else
      fail_to_destroy
    end

    respond_to do |format|
      format.html {
        redirect_to action: :index
      }
      format.json {
        render :json => [], :status => :ok
      }
    end
  end
end