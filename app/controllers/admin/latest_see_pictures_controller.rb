# encoding: utf-8
class Admin::LatestSeePicturesController < Admin::BaseController

  load_and_authorize_resource
  before_filter :set_latest_see

  def index
    @latest_see_pictures = initialize_grid(LatestSeePicture, conditions: {latest_see_id: @latest_see.id})
  end

  def create
    #@latest_see_picture = @latest_see.latest_see_pictures.new(params[:latest_see_picture])
    #if @latest_see_picture.save
    #  create_successfully
    #  redirect_to action: :index
    #else
    #  fail_to_create
    #  render action: :new
    #end

    p_attr = {}
    p_attr[:pic] = params[:files].first if params[:files].class == Array
    @latest_see_picture = @latest_see.latest_see_pictures.new(p_attr)
    if @latest_see_picture.save
      respond_to do |format|
        format.html {
          render :json => {files: [@latest_see_picture.to_jq_upload]}.as_json, :content_type => 'text/html', :layout => false
          redirect_to action: :index
        }
        format.json {
          render :json => {files: [@latest_see_picture.to_jq_upload]}.as_json, status: :ok
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
    @latest_see_picture = @latest_see.latest_see_pictures.find_by_id(params[:id])
    if @latest_see_picture.update_attributes(params[:latest_see_picture])
      update_successfully
      redirect_to action: :edit
    else
      fail_to_update
      render action: :edit
    end
  end

  def destroy
    @latest_see_picture = @latest_see.latest_see_pictures.find_by_id(params[:id])
    #if @latest_see_picture.destroy
    #  destroy_successfully
    #else
    #  fail_to_destroy
    #end
    #redirect_to action: :index

    @latest_see_picture.destroy if @latest_see_picture
    respond_to do |format|
      format.html {
        render :json => [], :status => :ok, :content_type => 'text/html', :layout => false
      }
      format.json {
        render :json => [], :status => :ok
      }
    end
  end

  private

  def set_latest_see
    unless (@latest_see = LatestSee.find_by_id(params[:latest_see_id]))
      render_404
    end
  end
end