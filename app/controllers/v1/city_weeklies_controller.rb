class V1::CityWeekliesController < V1::BaseController

  def index
    city_weeklies = []
    CityWeekly.where('status = 1').order('id DESC').limit(20).each do |weekly|
      city_weeklies << weekly.simple_json
    end

    res = {
        statusCode: 1,
        response: {
            cityWeekContentList: city_weeklies
        }
    }
    render json: res, status: :ok
  end

end