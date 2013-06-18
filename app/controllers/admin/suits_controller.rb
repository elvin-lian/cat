# encoding: utf-8
class Admin::SuitsController < Admin::BaseController
  load_and_authorize_resource

  def index
    if params[:new_product_id] and (@new_product = NewProduct.find_by_id(params[:new_product_id]))
      @suits = initialize_grid(Suit, conditions: {id: @new_product.suits.limit(1000).pluck(:suit_id)}, order: 'id', order_direction: 'desc')
    else
      @suits = initialize_grid(Suit, order: 'id', order_direction: 'desc')
    end
  end

  def new
    if (suit = Suit.last)
      rank = suit.id.to_i + 1
    else
      rank = 1
    end
    @suit = Suit.new(rank: rank)
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
      redirect_to action: :show
    else
      fail_to_update
      render action: :edit
    end
  end

  def destroy
    if (@suit = Suit.find_by_id(params[:id]))
      if params[:new_product_id]
        if (@new_product = NewProduct.find_by_id(params[:new_product_id]))
          @new_product.suits.delete(@suit)
        end
      else
        @suit.destroy
      end
      destroy_successfully
    else
      fail_to_destroy
    end
    redirect_to action: :index
  end

  def modify
    authorize! :update, Suit
    if request.xml_http_request?
      res = false
      if (suit = Suit.find_by_id(params[:id])) and suit.respond_to?(params[:name])
        val = params[:value]
        val = val.to_i if 'rank' == params[:name]
        res = suit.update_column(params[:name], val)
      end
      render json: {res: res, message: res ? t('admin.mess.update_successfully') : t('admin.mess.fail_to_update')}
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def export
    authorize! :update, Suit
    respond_to do |format|
      format.html {

      }
      format.xlsx {
        @created_from = Cat::Tool.to_date(params[:from])
        @created_from = Date.today - 30.days if @created_from.nil?
        @created_to = Cat::Tool.to_date(params[:to], true)
        @suits = Suit.where('created_at >= ? and created_at < ?', @created_from.to_time.utc, (@created_to + 1.day).to_time.utc).order('id desc').all
        render xlsx: 'export', disposition: "attachment", layout: false, filename: "suit_#{@created_from}_#{@created_to}"
      }
    end
  end
end