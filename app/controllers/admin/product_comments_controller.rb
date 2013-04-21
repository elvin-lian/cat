class Admin::ProductCommentsController < Admin::BaseController

  load_and_authorize_resource

  before_filter :set_product, :except => [:index, :destroy]

  def index
    if params[:product_id] and (@product = Product.find_by_id(params[:product_id]))
      @product_comments = initialize_grid(ProductComment, order: 'id', order_direction: 'desc', conditions: {product_id: params[:product_id]})
    else
      @product_comments = initialize_grid(ProductComment, order: 'id', order_direction: 'desc')
    end
  end

  def update
    @product_comment = @product.product_comments.find_by_id(params[:id])
    if @product_comment.update_attributes(params[:product_comment])
      update_successfully
      redirect_to action: :edit
    else
      fail_to_update
      render action: :edit
    end
  end

  def destroy
    @product_comment = ProductComment.find_by_id(params[:id])
    if @product_comment.destroy
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