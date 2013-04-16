class Admin::CategoriesController < Admin::BaseController

  load_and_authorize_resource

  def index
    @categories = initialize_grid(Category, order: 'id', order_direction: 'desc')
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      create_successfully
      redirect_to action: :index
    else
      fail_to_create
      render action: :new
    end
  end

  def update
    @category = Category.find_by_id(params[:id])
    if @category.update_attributes(params[:category])
      update_successfully
      redirect_to action: :edit
    else
      fail_to_update
      render action: :edit
    end
  end

  def destroy
    @category = Category.find_by_id(params[:id])
    if @category.destroy
      destroy_successfully
    else
      fail_to_destroy
    end
    redirect_to action: :index
  end
end