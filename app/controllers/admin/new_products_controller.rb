class Admin::NewProductsController < Admin::BaseController
  load_and_authorize_resource

  def index
    @new_products = initialize_grid(NewProduct, order: 'id', order_direction: 'desc')
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
      redirect_to action: :edit
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
end