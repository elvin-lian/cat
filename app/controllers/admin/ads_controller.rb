# encoding: utf-8
class Admin::AdsController < Admin::BaseController

  load_and_authorize_resource

  def index
    @ads = initialize_grid(Ad, order: 'id', order_direction: 'desc')
  end

  def create
    @ad = Ad.new(params[:ad])
    if @ad.save
      create_successfully
      redirect_to action: :index
    else
      fail_to_create
      render action: :new
    end
  end

  def update
    @ad = Ad.find_by_id(params[:id])
    if @ad.update_attributes(params[:ad])
      update_successfully
      redirect_to action: :show
    else
      fail_to_update
      render action: :edit
    end
  end

  def destroy
    @ad = Ad.find_by_id(params[:id])
    if @ad.destroy
      destroy_successfully
    else
      fail_to_destroy
    end
    redirect_to action: :index
  end
end