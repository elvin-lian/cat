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

  def export
    authorize! :update, Product
    respond_to do |format|
      format.html {

      }
      format.xlsx {
        @created_from = Cat::Tool.to_date(params[:from])
        @created_from = Date.today - 30.days if @created_from.nil?
        @created_to = Cat::Tool.to_date(params[:to], true)
        @products = Product.where('created_at >= ? and created_at < ?', @created_from.to_time.utc, (@created_to + 1.day).to_time.utc).order('id desc').all
        render xlsx: 'export', disposition: "attachment", layout: false, filename: "product_#{@created_from}_#{@created_to}"
      }
    end
  end

  def new
    if (pro = Product.last)
      rank = pro.id.to_i + 1
    else
      rank = 1
    end
    @product = Product.new(rank: rank)
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

  def modify
    authorize! :update, Product
    if request.xml_http_request?
      res = false
      if (product = Product.find_by_id(params[:id])) and product.respond_to?(params[:name])
        val = params[:value]
        val = val.to_i if 'rank' == params[:name]
        res = product.update_column(params[:name], val)
      end
      render json: {res: res, message: res ? t('admin.mess.update_successfully') : t('admin.mess.fail_to_update')}
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

end