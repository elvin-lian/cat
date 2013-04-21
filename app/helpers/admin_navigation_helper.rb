# coding: utf-8
module AdminNavigationHelper
  def admin_nav
    navigation = [
        ['控制面板', admin_dashboard_index_path, nil],
        ['品类', admin_categories_path, Category],
        ['新品', admin_new_products_path, NewProduct],
        ['套装', admin_suits_path, Suit],
        ['潮流速递', admin_trend_couriers_path, TrendCourier],
        ['单品', admin_products_path, Product],
        ['首页广告', admin_ads_path, Ad],
        ['都市周报', admin_city_weeklies_path, Brand],
        ['最新宾视', admin_latest_sees_path, LatestSee],
        ['品牌', admin_brands_path, Brand],
        ['店铺信息', admin_shop_infos_path, ShopInfo],
        ['管理员', admin_admins_path, Admin]
    ]

    html = ''
    navigation.each do |nav|
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