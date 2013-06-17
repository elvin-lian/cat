class Admin::ProductCommentsController < Admin::BaseController

  load_and_authorize_resource

  before_filter :set_product, :except => [:index, :destroy, :export]

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

  def export
    authorize! :update, ProductComment
    respond_to do |format|
      format.html {

      }
      format.xlsx {
        @created_from = Cat::Tool.to_date(params[:from])
        @created_from = Date.today - 30.days if @created_from.nil?
        @created_to = Cat::Tool.to_date(params[:to], true)
        @suits = ProductComment.where('created_at >= ? and created_at < ?', @created_from.to_time.utc, @created_to.to_time.utc).order('id desc').all
        render xlsx: 'export', disposition: "attachment", layout: false, filename: "comment_#{@created_from}_#{@created_to}"
      }
    end
  end

  private

  def set_product
    unless (@product = Product.find_by_id(params[:product_id]))
      render_404
    end
  end
end