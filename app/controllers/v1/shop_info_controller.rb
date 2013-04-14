# encoding: utf-8
class V1::ShopInfoController < V1::BaseController

  def index
    shop_info = ShopInfo.last
    if shop_info.nil?
      res = {
          statusCode: 0,
          errorMessage: '店铺信息不存在!'
      }
    else
      res = {
          statusCode: 1,
          response: {
              shopInfoImageURL: shop_info.full_pic_url,
              updateTime: shop_info.updated_at.to_s
          }
      }
    end
    render json: res
  end

end