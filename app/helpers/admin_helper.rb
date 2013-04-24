# coding: utf-8
module AdminHelper

  def status_icon(boolean)
    icon = '<i '
    icon << (boolean ? 'class="icon-check" title="已审核通过"' : 'class="icon-ban-circle" title="未通过审核"')
    icon << '></i>'
    icon.html_safe
    #boolean ? 'Y' : 'N'
  end


  def actions_buttons(obj, action, path = nil)
    actions_links obj, action, path, true
  end

  def actions_links(obj, action, path = nil, button = false)
    name = obj.class.name.tableize.singularize
    show_link, edit_link, delete_link = nil, nil, nil
    html = ''
    case action
      when 0
        html += '<a href="' + controller.send("admin_#{obj.class.name.tableize}_path") + '" class="btn" title="返回"><i class="icon-arrow-left"></i></a>'
      when 1
        show_link = path ? path : "admin_#{name}_path"
      when 2
        edit_link = path ? path : "edit_admin_#{name}_path"
      when 3
        show_link = "admin_#{name}_path"
        edit_link = "edit_admin_#{name}_path"
      when 4
        delete_link = path ? path : "admin_#{name}_path"
      when 5
        show_link = "admin_#{name}_path"
        delete_link = "admin_#{name}_path"
      when 6
        edit_link = "edit_admin_#{name}_path"
        delete_link = "admin_#{name}_path"
      when 7
        show_link = "admin_#{name}_path"
        edit_link = "edit_admin_#{name}_path"
        delete_link = "admin_#{name}_path"
      else
    end
    if action.in? [1, 2, 4] and path
      html += link_to_show(show_link, obj.class, button) if show_link
      html += link_to_edit(edit_link, obj.class, button) if edit_link
      html += link_to_delete(delete_link, obj.class, button) if delete_link
    else
      html += link_to_show(controller.send(show_link, obj), obj.class, button) if show_link
      html += link_to_edit(controller.send(edit_link, obj), obj.class, button) if edit_link
      html += link_to_delete(controller.send(delete_link, obj), obj.class, button) if delete_link
    end
    html.html_safe
  end

  def link_to_show(link, model, button = false)
    if button
      cc_link_to '<i class="icon-eye-open icon-white"></i>'.html_safe, link, title: '查看', class: 'btn btn-primary', cc: [:read, model, display: false]
    else
      cc_link_to '<i class="icon-eye-open"></i>'.html_safe, link, title: '查看', cc: [:read, model, display: false]
    end
  end

  def link_to_edit(link, model, button = false)
    if button
      cc_link_to '<i class="icon-edit icon-white"></i>'.html_safe, link, title: '编辑', class: 'btn btn-primary', cc: [:edit, model, display: false]
    else
      cc_link_to '<i class="icon-edit"></i>'.html_safe, link, title: '编辑', cc: [:edit, model, display: false]
    end
  end

  def link_to_delete(link, model, button = false)
    if button
      cc_link_to '<button class="btn"><i class="icon-trash icon-white"></i>'.html_safe, link, method: :delete, class: 'btn btn-danger', data: {confirm: '你确定要删除？'}, title: '删除', cc: [:destroy, model, display: false]
    else
      cc_link_to '<i class="icon-trash"></i>'.html_safe, link, method: :delete, data: {confirm: '你确定要删除？'}, title: '删除', cc: [:destroy, model, display: false]
    end
  end

end