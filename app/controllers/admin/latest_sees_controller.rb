# encoding: utf-8
class Admin::LatestSeesController < Admin::BaseController

  load_and_authorize_resource

  def index
    @latest_sees = initialize_grid(LatestSee, order: 'id', order_direction: 'desc')
    #@latest_see = LatestSee.last
    #if @latest_see.nil?
    #  @latest_see = LatestSee.create(title: 'default', status: 0)
    #end
    #redirect_to admin_latest_see_pictures_path(@latest_see)
  end

  def create
    @latest_see = LatestSee.new(params[:latest_see])
    if @latest_see.save
      flash[:success] = '请上传图片'
      redirect_to admin_latest_see_pictures_path(@latest_see)
    else
      fail_to_create
      render action: :new
    end
  end

  def update
    @latest_see = LatestSee.find_by_id(params[:id])
    if @latest_see.update_attributes(params[:latest_see])
      update_successfully
      redirect_to action: :edit
    else
      fail_to_update
      render action: :edit
    end
  end

  def destroy
    @latest_see = LatestSee.find_by_id(params[:id])
    if @latest_see.destroy
      destroy_successfully
    else
      fail_to_destroy
    end
    redirect_to action: :index
  end

  def export
    authorize! :update, LatestSee
    respond_to do |format|
      format.html {

      }
      format.xlsx {
        @created_from = Cat::Tool.to_date(params[:from])
        @created_from = Date.today - 30.days if @created_from.nil?
        @created_to = Cat::Tool.to_date(params[:to], true)
        @latest_sees = LatestSee.where('created_at >= ? and created_at < ?', @created_from.to_time.utc, (@created_to + 1.day).to_time.utc).order('id desc').all
        render xlsx: 'export', disposition: "attachment", layout: false, filename: "see_#{@created_from}_#{@created_to}"
      }
    end
  end

end