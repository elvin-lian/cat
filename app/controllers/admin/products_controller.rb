# encoding: utf-8
class Admin::ProductsController < Admin::BaseController
  load_and_authorize_resource

  def index
    if params[:category_id] and (@category = Category.find_by_id(params[:category_id]))
      @products = initialize_grid(Product, conditions: {id: @category.products.limit(1000).pluck(:product_id)}, order: 'id', order_direction: 'desc')
    elsif params[:suit_id] and (@suit = Suit.find_by_id(params[:suit_id]))
      @products = initialize_grid(Product, conditions: {id: @suit.products.limit(1000).pluck(:product_id)}, order: 'id', order_direction: 'desc')
    elsif params[:trend_courier_id] and (@trend_courier = TrendCourier.find_by_id(params[:trend_courier_id]))
      @products = initialize_grid(Product, conditions: {trend_courier_id: @trend_courier.id}, order: 'id', order_direction: 'desc')
    else
      @products = initialize_grid(Product, order: 'id', order_direction: 'desc')
    end
    @title_prefix = "“#{@title_prefix}”的" unless @title_prefix.blank?
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
      redirect_to action: :show
    else
      fail_to_update
      render action: :edit
    end
  end

  def destroy
    if (@product = Product.find_by_id(params[:id]))
      if params[:category_id]
        if (@category = Category.find_by_id(params[:category_id]))
          @category.products.delete(@product)
        end
      elsif params[:suit_id]
        if  (@suit = Suit.find_by_id(params[:suit_id]))
          @suit.products.delete(@product)
        end
      elsif params[:trend_courier_id]
        if (@trend_courier = TrendCourier.find_by_id(params[:trend_courier_id]))
          @product.update_column(:trend_courier_id, nil)
        end
      else
        @product.destroy
      end
      destroy_successfully
    else
      fail_to_destroy
    end
    redirect_to action: :index
  end

  def batch_unlisted
    render json: Logic::ProductTool.batch_listed(params, 0), status: :ok
  end

  def batch_listed
    render json: Logic::ProductTool.batch_listed(params, 1), status: :ok
  end

  def batch_destroy
    render json: Logic::ProductTool.batch_destroy(params), status: :ok
  end

  def batch_same_section
    render json: Logic::ProductTool.batch_set_same_section(params), status: :ok
  end

end