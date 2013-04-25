class Admin::ProductSameSectionsController < Admin::BaseController

  load_and_authorize_resource

  before_filter :set_product

  def index
    @product_same_sections = initialize_grid(ProductSameSection, order: 'id', order_direction: 'desc', conditions: {p_id: params[:product_id]})
  end

  def create
    Logic::ProductTool.batch_set_same_section({ids: @product.id.to_s + ',' + params[:product_same_section][:p_id]}.as_json)
    create_successfully
    redirect_to action: :index
  end

  def destroy
    @product_same_section = ProductSameSection.find_by_id(params[:id])
    if @product_same_section.destroy
      @product_same_section.clean_same_section
      destroy_successfully
    else
      fail_to_destroy
    end
    redirect_to admin_product_same_sections_path(@product)
  end

  private

  def set_product
    unless (@product = Product.find_by_id(params[:product_id]))
      render_404
    end
  end

end