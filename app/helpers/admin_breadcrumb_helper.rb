# encoding: utf-8
module AdminBreadcrumbHelper

  def ad_breadcrumb ad
    output_breadcrumb [['所有广告', admin_ads_path, cc: [:read, Ad]],
                       [ad.id, admin_ad_path(ad), cc: [:read, Ad]]]
  end


  private

  def output_breadcrumb breadcrumbs
    html = ''
    breadcrumbs.insert(0, ['首页', admin_dashboard_index_path])

    breads = []
    breadcrumbs.each do |bread|
      next if bread.empty? or bread.first.nil?
      if bread.third
        breads << cc_link_to(bread.first, bread.second, cc: [bread.third[:cc].first, bread.third[:cc].second, display: false])
      elsif bread.second
        breads << link_to(bread.first, bread.second)
      elsif bread.first
        breads << bread.first
      end
    end

    html << '<ul class="breadcrumb"><li>'
    html << breads.join('<span class="divider">/</span></li><li>')
    html << '</li></ul>'
    html.html_safe
  end

end