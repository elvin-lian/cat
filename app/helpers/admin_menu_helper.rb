# coding: utf-8
module AdminMenuHelper

  def admin_left_menu model
    menus ={
        admin: [
            ['管理员', nil],
            ['所有', admin_admins_path, {path: 'admins#index', cc: [:read, Admin]}],
            ['添加', new_admin_admin_path, {path: 'admins#new', cc: [:create, Admin]}]
        ],
        ad: [
            ['首页广告', nil],
            ['所有广告', admin_ads_path, {path: 'ads#index', cc: [:read, Ad]}],
            ['添加', new_admin_ad_path, {path: 'ads#new', cc: [:read, Ad]}]
        ],

        category: [
            ['商品品类', nil],
            ['所有品类', admin_categories_path, {path: 'categories#index', cc: [:read, Category]}],
            ['添加品类', new_admin_category_path, {path: 'categories#new', cc: [:create, Category]}]
        ],

        city_weekly: [
            ['都市周报', nil],
            ['所有周报', admin_city_weeklies_path, {path: 'city_weeklies#index', cc: [:read, CityWeekly]}],
            ['添加周报', new_admin_city_weekly_path, {path: 'city_weeklies#new', cc: [:create, CityWeekly]}]
        ],

        latest_see: [
            ['最新宾视', nil],
            ['所有', admin_latest_sees_path, {path: 'latest_sees#index', cc: [:read, LatestSee]}],
            ['发布新一期', new_admin_latest_see_path, {path: 'latest_sees#new', cc: [:create, LatestSee]}]
        ],

        new_product: [
            ['新品', nil],
            ['所有新品', admin_new_products_path, {path: 'new_products#index', cc: [:read, NewProduct]}],
            ['添加新品', new_admin_new_product_path, {path: 'new_products#new', cc: [:create, NewProduct]}]
        ],

        product: [
            ['单品', nil],
            ['所有单品', admin_products_path, {path: 'products#index', cc: [:read, Product]}],
            ['添加单品', new_admin_product_path, {path: 'products#new', cc: [:create, Product]}],
            ['评价', nil],
            ['所有评价', admin_products_comments_path, {path: 'product_comments#index', cc: [:read, ProductComment]}]
        ],

        suit: [
            ['单品', nil],
            ['所有套装', admin_suits_path, {path: 'suits#index', cc: [:read, Suit]}],
            ['添加套装', new_admin_suit_path, {path: 'suits#new', cc: [:create, Suit]}]
        ],

        trend_courier: [
            ['单品', nil],
            ['潮流速递', admin_trend_couriers_path, {path: 'suits#index', cc: [:read, TrendCourier]}],
            ['添加潮流速递', new_admin_trend_courier_path, {path: 'suits#new', cc: [:create, TrendCourier]}]
        ],
    }

    menus[model.to_sym] ? output_menu(menus[model.to_sym]) : ''
  end

  private

  def output_menu menus
    html = ''
    menus.each do |menu|
      if menu.second.nil?
        html << '<li'
        html << ' class="nav-header"'
        html << ">#{menu.first}</li>"
      elsif menu.third
        active_class = nil
        active_class = nav_active_class(menu.third[:path], 'active') if menu.third[:path]

        if menu.third[:cc]
          html << cc_link_to(menu.first, menu.second, cc: [menu.third[:cc].first, menu.third[:cc].second, display: false, before: '<li>', after: '</li>', class: active_class])
        else
          active_class = '' if active_class.nil?
          html << "<li class=\"#{active_class}\">" + link_to(menu.first, menu.second) + '</li>'
        end
      end
    end
    @admin_left_menu = html.html_safe
  end
end