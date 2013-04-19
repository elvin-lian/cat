class V1::BaseController < ActionController::Base

  respond_to :json

  before_filter :validate_device

  protected

  def validate_device
    #uid = params['userID']
    #if uid.blank?
    #  render json: {status: 0, message: I18n::t('api.mess.invalidate_request')}, status: :forbidden
    #else
    #  unless (@device = Device.find_by_uid(uid))
    #    render json: {status: 0, message: I18n::t('api.mess.user_not_exist')}, status: :not_found
    #  end
    #end
  end

end