module ApplicationHelper

  def t2l(time, format = '%Y-%m-%d %H:%M')
    time.nil? ? '' : time.localtime.strftime(format)
  end

  def nav_active_class actions, default_active_class = 'current'
      if actions.is_a?(String)
        actions = [actions]
      end
      res = nil
      actions.each do |action|
        params = c_params = nil
        controller_name, action_name = action.split('#')
        if action_name
          c_params = controller.params
          c_params.delete(:action)
          c_params.delete(:controller)
          params = {}
          action_name, params_str = action_name.split('?')
          if params_str
            params_str.split('&').each do |para|
              params[para.split('=').first] = para.split('=').second
            end
          end
        end

        res = default_active_class if (controller_name == controller.controller_name) and (action_name.nil? or action_name == controller.action_name) and (params == c_params)
        break unless res.nil?
      end
      res
    end
end
