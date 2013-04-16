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

        new_product: [
            ['新品分类', nil],
            ['所有分类', admin_new_products_path, {path: 'new_products#index', cc: [:read, NewProduct]}],
            ['添加分类', new_admin_new_product_path, {path: 'new_products#new', cc: [:create, NewProduct]}]
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