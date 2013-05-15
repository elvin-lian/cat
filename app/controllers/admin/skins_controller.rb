# encoding: utf-8
class Admin::SkinsController < Admin::BaseController
  load_and_authorize_resource

  def index
    @skins = initialize_grid(Skin, order: 'id', order_direction: 'desc')
  end

  def new
    @skin = Skin.last
    if @skin.nil? or !@skin.title.nil?
      @skin = Skin.create()
    end
    redirect_to edit_admin_skin_path(@skin)
  end

  #def create
  #  @skin = Skin.new(params[:skin])
  #  if @skin.save
  #    create_successfully
  #    redirect_to action: :index
  #  else
  #    fail_to_create
  #    render action: :new
  #  end
  #end

  def update
    @skin = Skin.find_by_id(params[:id])
    if @skin.update_attributes(params[:skin])
      if @skin.status?
        Skin.update_all('status = 0', "id != #{@skin.id}")
      end
      name, _ = params[:skin].first
      respond_to do |format|
        format.html {
          update_successfully
          redirect_to action: :show
        }
        format.json {
          render :json => {status: 1, message: '上传成功', thumb_link: @skin.fill_thumb_pic_url(name), link: @skin.fill_pic_url(name)}.as_json, status: :ok
        }
      end

    else
      respond_to do |format|
        format.html {
          fail_to_update
          redirect_to action: :edit
        }
        format.json {
          render :json => {status: 0, message: '上传失败'}.as_json, status: :ok
        }
      end

    end
  end

  def destroy
    @skin = Skin.find_by_id(params[:id])
    if @skin.destroy
      destroy_successfully
    else
      fail_to_destroy
    end
    redirect_to action: :index
  end
end