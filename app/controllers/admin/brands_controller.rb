class Admin::BrandsController < Admin::BaseController

  load_and_authorize_resource

  def index
    @brand = Brand.last
    @brand = Brand.new if @brand.nil?
  end

  def create
    @brand = Brand.new(params[:brand])
    if @brand.save
      create_successfully
      redirect_to action: :index
    else
      fail_to_create
      redirect_to action: :index
    end
  end

  def update
    @brand = Brand.find_by_id(params[:id])
    if @brand.update_attributes(params[:brand])
      update_successfully
    else
      fail_to_update
    end

    redirect_to action: :index
  end

  def destroy
    @brand = Brand.find_by_id(params[:id])
    if @brand.destroy
      destroy_successfully
    else
      fail_to_destroy
    end
    redirect_to action: :index
  end

end