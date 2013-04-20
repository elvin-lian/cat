# encoding: utf-8
class V1::ProductCommentsController < V1::BaseController

  def create
    param = nil
    device_id = 0
    if (device = Device.find_by_uid(params[:userID]))
      device_id = device.id
    end

    product = Product.find_by_id(params[:productID])
    if product
      param = {
          device_id: device_id,
          product_id: product.id,
          price_score: params[:evaluatePriceScore].to_i,
          design_score: params[:evaluateDesignScore].to_i,
          fabric_score: params[:evaluateFabricScore].to_i
      }
    end

    res = nil
    if param
      product_comment = ProductComment.create(param)
      if product_comment and product_comment.id
        res = {
            statusCode: 1,
            response: {}
        }
      end
    end

    if res.nil?
      res = {
          statusCode: 0,
          errorMessage: '添加失败'
      }

    end

    render json: res, status: :ok
  end

end