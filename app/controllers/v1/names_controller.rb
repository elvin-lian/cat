class V1::NamesController < V1::BaseController

  def index
    render json: Logic::NameTool.as_json, status: :ok
  end
end