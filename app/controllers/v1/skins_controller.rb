# encoding: utf-8
class V1::SkinsController < V1::BaseController

  def index
    if (@skin = Skin.where('status = 1').last) and @skin.status?
      res = {
          statusCode: 1,
          response: @skin.simple_json
      }
    else
      res = {
          statusCode: 0,
          errorMessage: '没有皮肤数据'
      }
    end
    render json: res, status: :ok
  end

  def show
    if (@skin = Skin.find_by_id(params[:id])) and @skin.status?
      res = {
          statusCode: 1,
          response: @skin.simple_json
      }
    else
      res = {
          statusCode: 0,
          errorMessage: '没有皮肤数据'
      }
    end
    render json: res, status: :ok
  end
end