# encoding: utf-8
class Admin::ProductsController < Admin::BaseController
  load_and_authorize_resource

  def index
    @products = initialize_grid(Product, order: 'id', order_direction: 'desc')
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:success] = '请继续上传单品图片'
      redirect_to admin_product_pictures_path(@product)
    else
      fail_to_create
      render action: :new
    end
  end

  def update
    @product = Product.find_by_id(params[:id])
    if @product.update_attributes(params[:product])
      update_successfully
      redirect_to action: :edit
    else
      fail_to_update
      render action: :edit
    end
  end

  def destroy
    @product = Product.find_by_id(params[:id])
    if @product.destroy
      destroy_successfully
    else
      fail_to_destroy
    end
    redirect_to action: :index
  end
end