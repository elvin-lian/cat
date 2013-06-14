Cabbeen::Application.routes.draw do

  root :to => "home#index"

  def api_v1_routes
    namespace :v1 do
      resources :brand_info, :only => :index
      resources :city_weeklies, :only => :index
      resources :launch, :only => :create
      resources :lastest_see, :only => :index
      resources :products, :only => [:index, :show]
      resources :product_comments, :only => :create
      resources :shop_info, :only => :index
      resources :suits, :only => :index do
        collection do
          get 'search'
        end
      end
      resources :trend_couriers, :only => [:index, :show]
      resources :skins, :only => [:show, :index]
      resources :names, :only => [:index]
    end
  end

  def admin_routes

    devise_for :admins

    match '/admin' => redirect('/admins/sign_in')

    namespace :admin do

      resources :admins do
        collection do
          get 'edit_pwd' => 'admins#edit_pwd'
          put 'edit_pwd' => 'admins#update_pwd'
        end
      end

      resources :ads
      resources :brands
      resources :categories do
        resources :products
        collection do
          post 'modify/:id' => 'categories#modify'
        end
      end
      resources :city_weeklies
      resources :dashboard, :only => :index
      resources :latest_sees, :only => :index do
        resources :pictures, :controller => :latest_see_pictures do
          collection do
            post 'modify/:id' => 'latest_see_pictures#modify'
          end
        end
      end
      resources :new_products do
        resources :suits
        collection do
          post 'modify/:id' => 'new_products#modify'
        end
      end
      resources :products do
        resources :comments, :controller => :product_comments
        resources :pictures, :controller => :product_pictures do
          collection do
            post 'modify/:id' => 'product_pictures#modify'
          end
        end
        resources :same_sections, :controller => :product_same_sections

        collection do
          get 'export'
          post 'batch_listed'
          post 'batch_unlisted'
          post 'batch_destroy'
          post 'batch_same_section'
          post 'modify/:id' => 'products#modify'
        end

      end
      get 'products_comments' => 'product_comments#index'

      resources :shop_infos
      resources :suits do
        collection do
          post 'modify/:id' => 'suits#modify'
        end
        resources :products
      end

      resources :skins
      resources :trend_couriers do
        resources :products
      end
    end
  end

  api_v1_routes
  admin_routes
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
