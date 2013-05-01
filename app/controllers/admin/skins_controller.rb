class Admin::SkinsController < Admin::BaseController
  load_and_authorize_resource
 
   def index
     @skins = initialize_grid(Skin, order: 'id', order_direction: 'desc')
   end
 
   def create
     @skin = Skin.new(params[:skin])
     if @skin.save
       create_successfully
       redirect_to action: :index
     else
       fail_to_create
       render action: :new
     end
   end
 
   def update
     @skin = Skin.find_by_id(params[:id])
     if @skin.update_attributes(params[:skin])
       update_successfully
       redirect_to action: :edit
     else
       fail_to_update
       render action: :edit
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