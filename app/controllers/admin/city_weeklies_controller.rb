class Admin::CityWeekliesController < Admin::BaseController

  load_and_authorize_resource

  def index
    @city_weeklies = initialize_grid(CityWeekly, order: 'id', order_direction: 'desc')
  end

  def create
    @city_weekly = CityWeekly.new(params[:city_weekly])
    if @city_weekly.save
      create_successfully
      redirect_to action: :index
    else
      fail_to_create
      render action: :new
    end
  end

  def update
    @city_weekly = CityWeekly.find_by_id(params[:id])
    if @city_weekly.update_attributes(params[:city_weekly])
      update_successfully
      redirect_to action: :show
    else
      fail_to_update
      render action: :edit
    end
  end

  def destroy
    @city_weekly = CityWeekly.find_by_id(params[:id])
    if @city_weekly.destroy
      destroy_successfully
    else
      fail_to_destroy
    end
    redirect_to action: :index
  end

end