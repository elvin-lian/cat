# coding: utf-8
module AdminNavigationHelper
  def admin_nav
    navs = [
        ['控制面板', admin_dashboard_index_path, nil],
        ['管理员', admin_admins_path, Admin]
    ]

    html = ''
    navs.each do |nav|
      active_class = (nav.second =~ /\/#{controller.controller_name}/ or request.url =~ /#{nav.second}\//) ? 'active' : nil
      if nav.third
        html << cc_link_to(nav.first, nav.second, cc: [:read, nav.third, display: false, before: '<li>', after: '</li>', class: active_class])
      else
        html << "<li class=\"#{active_class}\">" + link_to(nav.first, nav.second) + '</li>'
      end
    end
    html.html_safe
  end

end