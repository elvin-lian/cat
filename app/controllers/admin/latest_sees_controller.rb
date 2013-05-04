# encoding: utf-8
class Admin::LatestSeesController < Admin::BaseController

  load_and_authorize_resource

  def index
    #@latest_sees = initialize_grid(LatestSee, order: 'id', order_direction: 'desc')
    @latest_see = LatestSee.last
    if @latest_see.nil?
      @latest_see = LatestSee.create(title: 'default', status: 0)
    end
    redirect_to admin_latest_see_pictures_path(@latest_see)
  end

  #def create
  #  @latest_see = LatestSee.new(params[:latest_see])
  #  if @latest_see.save
  #    flash[:success] = '请上传图片'
  #    redirect_to admin_latest_see_pictures_path(@latest_see)
  #  else
  #    fail_to_create
  #    render action: :new
  #  end
  #end
  #
  #def update
  #  @latest_see = LatestSee.find_by_id(params[:id])
  #  if @latest_see.update_attributes(params[:latest_see])
  #    update_successfully
  #    redirect_to action: :edit
  #  else
  #    fail_to_update
  #    render action: :edit
  #  end
  #end
  #
  #def destroy
  #  @latest_see = LatestSee.find_by_id(params[:id])
  #  if @latest_see.destroy
  #    destroy_successfully
  #  else
  #    fail_to_destroy
  #  end
  #  redirect_to action: :index
  #end
end