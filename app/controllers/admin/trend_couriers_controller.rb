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
      redirect_to action: :show
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


  def export
    authorize! :update, TrendCourier
    respond_to do |format|
      format.html {

      }
      format.xlsx {
        @created_from = Cat::Tool.to_date(params[:from])
        @created_from = Date.today - 30.days if @created_from.nil?
        @created_to = Cat::Tool.to_date(params[:to], true)
        @trend_couriers = TrendCourier.where('created_at >= ? and created_at < ?', @created_from.to_time.utc, (@created_to + 1.day).to_time.utc).order('id desc').all
        render xlsx: 'export', disposition: "attachment", layout: false, filename: "trend_courier_#{@created_from}_#{@created_to}"
      }
    end
  end
end