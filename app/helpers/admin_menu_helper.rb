# coding: utf-8
module AdminMenuHelper

  def admin_left_menu model
    menus ={
        admin: [
            ['管理员', nil],
            ['所有', admin_admins_path, {path: 'admins#index', cc: [:read, Admin]}],
            ['添加', new_admin_admin_path, {path: 'admins#new', cc: [:create, Admin]}]
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