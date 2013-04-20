# encoding: utf-8
class V1::SuitsController < V1::BaseController

  def index
    start_pos = params[:startPos].to_i
    start_pos = start_pos - 1
    start_pos = 0 if start_pos < 0

    length = params[:length].to_i
    length = 10 if length < 1

    new_product_id = params[:lastestProductID]
    product_id = params[:productID]

    if new_product_id
      new_product = NewProduct.find_by_id(new_product_id)
      if new_product and new_product.suits
        @suits = new_product.suits
      end
    elsif product_id
      product = Product.find_by_id(product_id)
      if product and product.suits
        @suits = product.suits
      end
    else
      @suits = []
    end

    if @suits.empty?
      res = {
          statusCode: 0,
          errorMessage: "非法操作"
      }
    else

      case params[:orderStyle].to_i
        when 2
          order = 'suits.id ASC'
        when 3
          order = 'suits.updated_at DESC'
        when 4
          order = 'suits.updated_at ASC'
        when 5
          order = 'suits.serial_number DESC'
        when 6
          order = 'suits.serial_number ASC'
        else
          order = 'suits.id DESC'
      end

      @suits = @suits.where('suits.status = 1').order(order).limit(length).offset(start_pos)

      suits_arr = []
      @suits.each do |suit|
        suits_arr << suit.simple_as_json
      end

      res = {
          statusCode: 1,
          response: {
              suitArray: suits_arr
          }
      }

    end

    render json: res, :status => :ok

  end

end