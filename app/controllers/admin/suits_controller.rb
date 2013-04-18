class Admin::SuitsController < Admin::BaseController
  load_and_authorize_resource

  def index
    @suits = initialize_grid(Suit, order: 'id', order_direction: 'desc')
  end

  def create
    @suit = Suit.new(params[:suit])
    if @suit.save
      create_successfully
      redirect_to action: :index
    else
      fail_to_create
      render action: :new
    end
  end

  def update
    @suit = Suit.find_by_id(params[:id])
    if @suit.update_attributes(params[:suit])
      update_successfully
      redirect_to action: :edit
    else
      fail_to_update
      render action: :edit
    end
  end

  def destroy
    @suit = Suit.find_by_id(params[:id])
    if @suit.destroy
      destroy_successfully
    else
      fail_to_destroy
    end
    redirect_to action: :index
  end
end