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

  def alternative first_value, second_value
    first_value.blank? ? second_value : first_value
  end

  def nav name, abbr_name, controllers_and_actions = {}, url = nil, opens_in_a_new_window = false, &block
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
      "<li><a href=\"#{url}\"#{ 'target="_blank"' if opens_in_a_new_window}#{' class="active"' if actived}><span class=\"nav-icon-hexa\">#{abbr_name}</span> #{name}</a></li>"
    end)
  end

  def grouped_properties_of_model_with_cascades_options model
    grouped_attributes_of_model_with_cascades_options(model, :property)
  end

  def grouped_presenters_of_model_with_cascades_options model
    grouped_attributes_of_model_with_cascades_options(model, :presenter)
  end

  protected
    def grouped_attributes_of_model_with_cascades_options model, type
      grouped_options_for_select(([model] + model.belongs(3)).map do |model|
        [model.name, case type
                     when :property then model.properties.map{ |property| [property.name, property.id]}
                     when :presenter then model.presenters.map{ |presenter| [presenter.name, presenter.id]}
                     end]
      end)
    end
end
