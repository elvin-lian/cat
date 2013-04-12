module CancanLinkToHelper

  def cc_link_to(*args, &block)
    html = ""
    html_options = block_given? ? args.second : args[2]
    if html_options and html_options[:cc]
      cancan_args = html_options[:cc]
      link = ""
      is_can = false
      if can?(cancan_args[0], cancan_args[1])
        html_options = html_options.tap { |h| h.delete(:cc) }
        link = block_given? ? link_to(args.first, html_options, &block) : link_to(args[0], args[1], html_options)
        is_can = true
      else
        link = args[0]
      end

      if (cancan_options = cancan_args[2])
        if (cancan_options[:display] == false or cancan_options[:display] == 'none') and !is_can
          html = ""
        else
          if cancan_options[:default] and !is_can
            link = cancan_options[:default]
          end
          if cancan_options[:before]
            before_str = cancan_options[:before]
            tmp = ''
            cancan_options.map do |k, v|
              tmp << " #{k}=\"#{v}\"" if !%w(before after display default).include?(k.to_s) and v
            end
            before_str = before_str.gsub(/>/, tmp + '>') if tmp != ''
            html += before_str
          end
          html += link
          html += cancan_options[:after] if cancan_options[:after]
        end
      else
        html = link
      end
    else
      html = block_given? ? link_to(args.first, args.second, &block) : link_to(args[0], args[1], args[2])
    end
    html.html_safe
  end

end