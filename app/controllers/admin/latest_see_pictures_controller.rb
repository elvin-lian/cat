class Admin::LatestSeePicturesController < Admin::BaseController

  load_and_authorize_resource
  before_filter :set_latest_see

  def index
    @latest_see_pictures = initialize_grid(LatestSeePicture, conditions: {latest_see_id: @latest_see.id})
  end

  def create
    @latest_see_picture = @latest_see.latest_see_pictures.new(params[:latest_see_picture])
    if @latest_see_picture.save
      create_successfully
      redirect_to action: :index
    else
      fail_to_create
      render action: :new
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
    if @latest_see_picture.destroy
      destroy_successfully
    else
      fail_to_destroy
    end
    redirect_to action: :index
  end

  private

  def set_latest_see
    unless (@latest_see = LatestSee.find_by_id(params[:latest_see_id]))
      render_404
    end
  end
end