class V1::ProductsController < V1::BaseController

  def index
    render json: Logic::ProductTool.products_json(params), status: :ok
  end

  def show
    render json: Logic::ProductTool.product_json(params), status: :ok
  end
end