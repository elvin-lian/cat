# encoding: utf-8
class Admin::ProductPicturesController < Admin::BaseController

  load_and_authorize_resource
  before_filter :set_product

  def index
    @product_pictures = initialize_grid(ProductPicture, conditions: {product_id: @product.id})
  end

  def create
    p_attr = {}
    p_attr[:pic] = params[:files].first if params[:files].class == Array

    @product_picture = @product.product_pictures.new(p_attr)

    if @product_picture.save
      respond_to do |format|
        format.html {
          render :json => {files: [@product_picture.to_jq_upload]}.as_json, :content_type => 'text/html', :layout => false
          redirect_to action: :index
        }
        format.json {
          render :json => {files: [@product_picture.to_jq_upload]}.as_json, status: :ok
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

  #def update
  #  @product_picture = @product.product_pictures.find_by_id(params[:id])
  #  if @product_picture.update_attributes(params[:product_picture])
  #    update_successfully
  #    redirect_to action: :edit
  #  else
  #    fail_to_update
  #    render action: :edit
  #  end
  #end

  def destroy
    @product_picture = @product.product_pictures.find_by_id(params[:id])
    @product_picture.destroy

    respond_to do |format|
      format.html {
        render :json => [], :status => :ok, :content_type => 'text/html', :layout => false
      }
      format.json {
        render :json => [], :status => :ok
      }
    end
  end

  def modify
    authorize! :update, ProductPicture
    if request.xml_http_request?
      res = false
      if (picture = ProductPicture.find_by_id(params[:id])) and picture.respond_to?(params[:name])
        res = picture.update_column(params[:name], params[:value])
      end
      render json: {res: res, message: res ? t('admin.mess.update_successfully') : t('admin.mess.fail_to_update')}
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  private

  def set_product
    unless (@product = Product.find_by_id(params[:product_id]))
      render_404
    end
  end

end