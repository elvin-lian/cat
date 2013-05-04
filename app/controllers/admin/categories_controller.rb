class Admin::CategoriesController < Admin::BaseController

  load_and_authorize_resource

  def index
    @categories = initialize_grid(Category, order: 'id', order_direction: 'desc', :per_page => 30)
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


  def modify
    authorize! :update, Category
    if request.xml_http_request?
      res = false
      if (category = Category.find_by_id(params[:id])) and category.respond_to?(params[:name])
        val = params[:value]
        val = val.to_i if 'rank' == params[:name]
        res = category.update_column(params[:name], val)
      end
      render json: {res: res, message: res ? t('admin.mess.update_successfully') : t('admin.mess.fail_to_update')}
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end