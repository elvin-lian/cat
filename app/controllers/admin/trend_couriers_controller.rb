class Admin::TrendCouriersController < Admin::BaseController
  load_and_authorize_resource

  def index
    @trend_couriers = initialize_grid(TrendCourier, order: 'id', order_direction: 'desc')
  end

  def create
    @trend_courier = TrendCourier.new(params[:trend_courier])
    if @trend_courier.save
      create_successfully
      redirect_to action: :index
    else
      fail_to_create
      render action: :new
    end
  end

  def update
    @trend_courier = TrendCourier.find_by_id(params[:id])
    if @trend_courier.update_attributes(params[:trend_courier])
      update_successfully
      redirect_to action: :edit
    else
      fail_to_update
      render action: :edit
    end
  end

  def destroy
    @trend_courier = TrendCourier.find_by_id(params[:id])
    if @trend_courier.destroy
      destroy_successfully
    else
      fail_to_destroy
    end
    redirect_to action: :index
  end
end