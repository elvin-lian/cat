class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
      admin_dashboard_index_path
    else
      super
    end
  end

  def render_404
    render file: "#{Rails.root}/public/404", formats: [:html], status: 404, layout: false
  end
end
