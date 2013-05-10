class Admin::NewProductsController < Admin::BaseController
  load_and_authorize_resource

  def index
    @new_products = initialize_grid(NewProduct, order: 'rank', order_direction: 'asc', :per_page => 30)
  end

  def create
    @new_product = NewProduct.new(params[:new_product])
    if @new_product.save
      create_successfully
      redirect_to action: :index
    else
      fail_to_create
      render action: :new
    end
  end

  def update
    @new_product = NewProduct.find_by_id(params[:id])
    if @new_product.update_attributes(params[:new_product])
      update_successfully
      redirect_to action: :show
    else
      fail_to_update
      render action: :edit
    end
  end

  def destroy
    @new_product = NewProduct.find_by_id(params[:id])
    if @new_product.destroy
      destroy_successfully
    else
      fail_to_destroy
    end
    redirect_to action: :index
  end

  def modify
    authorize! :update, NewProduct
    if request.xml_http_request?
      res = false
      if (new_product = NewProduct.find_by_id(params[:id])) and new_product.respond_to?(params[:name])
        val = params[:value]
        val = val.to_i if 'rank' == params[:name]
        res = new_product.update_column(params[:name], val)
      end
      render json: {res: res, message: res ? t('admin.mess.update_successfully') : t('admin.mess.fail_to_update')}
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end