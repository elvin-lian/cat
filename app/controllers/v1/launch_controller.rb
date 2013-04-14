class V1::LaunchController < V1::BaseController

  skip_before_filter :validate_device

  def create
    render json: Logic::Launch.init(params)
  end

end