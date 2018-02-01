module ApplicationHelper
  def arm_t model
    t "activerecord.models.#{model}"
  end

  def ara_t model_with_attribute
    t "activerecord.attributes.#{model_with_attribute}"
  end

  def amm_t model
    t "activemodel.models.#{model}"
  end

  def ama_t model_with_attribute
    t "activemodel.attributes.#{model_with_attribute}"
  end

  def nav name, abbr_name, controllers_and_actions = {}, url = nil, &block
    actived = false
    controllers_and_actions.each do |controller, actions|
      if ((controller.to_s == controller_name) & (actions == :all ? true : actions.map(&:to_s).include?(action_name)))
        actived = true
        break
      end
    end
    raw(if block_given?
      "<li#{' class="open"' if actived}><a href=\"#\"#{' class="active"' if actived}><span class=\"nav-icon-hexa\">#{abbr_name}</span> #{name}</a><ul>#{capture(&block)}</ul></li>"
    else
      "<li><a href=\"#{url}\"#{' class="active"' if actived}><span class=\"nav-icon-hexa\">#{abbr_name}</span> #{name}</a></li>"
    end)
  end
end
