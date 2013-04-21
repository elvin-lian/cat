class V1::LastestSeeController < V1::BaseController

  def index
    data = []

    if (see = LatestSee.last)
      data = see.simple_json
    end

    res = {
        statusCode: 1,
        response: {
            lastestSeeImageList: data
        }
    }
    render json: res, status: :ok
  end

end