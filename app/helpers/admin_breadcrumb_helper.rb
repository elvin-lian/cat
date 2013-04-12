# encoding: utf-8
module AdminBreadcrumbHelper

  #def column_breadcrumb column
  #  output_breadcrumb [['所有专栏', admin_columns_path, cc: [:read, Column]],
  #                     [column.id, admin_column_path(column), cc: [:read, Column]]]
  #end


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