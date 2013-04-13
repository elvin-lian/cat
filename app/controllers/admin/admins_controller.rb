class Admin::AdminsController < Admin::BaseController

  load_and_authorize_resource :except => :create

  def index
    @admins = initialize_grid(Admin)
  end

  def new
    @admin = Admin.new
    @admin.role = 'manager'
  end

  def create
    authorize! :create, Admin
    admin = params[:admin]
    @admin = Admin.new
    @admin.name = admin[:name]
    @admin.email = admin[:email]
    @admin.password = admin[:password]
    @admin.password_confirmation = admin[:password_confirmation]
    @admin.role = admin[:role]
    if @admin.save
      create_successfully
      redirect_to action: :index
    else
      fail_to_create
      render action: :new
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    admin = params[:admin]
    @admin = Admin.find(params[:id])
    @admin.name = admin[:name]
    @admin.email = admin[:email]
    @admin.role = admin[:role]
    if @admin.save
      update_successfully
      redirect_to action: :index
    else
      fail_to_update
      render action: :edit
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy ? destroy_successfully : fail_to_destroy
    redirect_to action: :index
  end

  def edit_pwd
  end

  def update_pwd
    if current_admin.update_with_password(params[:admin])
      update_successfully
      redirect_to action: :edit_pwd
    else
      fail_to_update
      render action: :edit_pwd
    end
  end

end