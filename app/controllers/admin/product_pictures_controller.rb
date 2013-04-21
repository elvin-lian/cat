class Admin::ProductPicturesController < Admin::BaseController

  load_and_authorize_resource
  before_filter :set_product

  def index
    @product_pictures = initialize_grid(ProductPicture, conditions: {product_id: @product.id})
  end

  def create
    @product_picture = @product.product_pictures.new(params[:product_picture])
    if @product_picture.save
      create_successfully
      redirect_to action: :index
    else
      fail_to_create
      render action: :new
    end
  end

  def update
    @product_picture = @product.product_pictures.find_by_id(params[:id])
    if @product_picture.update_attributes(params[:product_picture])
      update_successfully
      redirect_to action: :edit
    else
      fail_to_update
      render action: :edit
    end
  end

  def destroy
    @product_picture = @product.product_pictures.find_by_id(params[:id])
    if @product_picture.destroy
      destroy_successfully
    else
      fail_to_destroy
    end
    redirect_to action: :index
  end

  private

  def set_product
    unless (@product = Product.find_by_id(params[:product_id]))
      render_404
    end
  end

end