class V1::BaseController < ActionController::Base

  respond_to :json

  before_filter :validate_user

  protected

  def validate_user
    uid = params['userID'] if uid.nil?
    if uid.blank?
      render json: {status: 0, message: I18n::t('api.mess.invalidate_request')}, status: :forbidden
    else
      unless (@user = User.find_by_uid(uid))
        render json: {status: 0, message: I18n::t('api.mess.user_not_exist')}, status: :not_found
      end
    end
  end

end