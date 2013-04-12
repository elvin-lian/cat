class Admin::DashboardController < Admin::BaseController

  skip_authorization_check only: [:index]

  def index

  end
end