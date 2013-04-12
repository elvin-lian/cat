class Admin::BaseController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_admin!

  check_authorization

  layout 'admin_main'

  rescue_from ActiveRecord::RecordNotFound do
    render file: "#{Rails.root}/public/404", formats: [:html], status: 404, layout: false
  end

  rescue_from CanCan::AccessDenied do |exception|
    render file: "#{Rails.root}/public/403", formats: [:html], status: 403, layout: false
  end

  def current_ability
    @current_ability ||= AdminAbility.new(current_admin)
  end

  def render_404
    render file: "#{Rails.root}/public/404", formats: [:html], status: 404, layout: false
  end

  protected

  def create_successfully
    flash[:success] = t('admin.mess.create_successfully')
  end

  def fail_to_create mess = nil
    flash[:error] = t('admin.mess.fail_to_create') + _mess(mess)
  end

  def update_successfully
    flash[:success] = t('admin.mess.update_successfully')
  end

  def fail_to_update mess = nil
    flash[:error] = t('admin.mess.fail_to_update') + _mess(mess)
  end

  def destroy_successfully
    flash[:success] = t('admin.mess.destroy_successfully')
  end

  def fail_to_destroy mess = nil
    flash[:error] = t('admin.mess.fail_to_destroy') + _mess(mess)
  end


  private

  def _mess mess
    mess.blank? ? '' : ':    ' + mess.to_s
  end

end