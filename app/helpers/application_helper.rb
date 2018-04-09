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
      if ((controller.to_s == controller_name) and (actions == :all ? true : actions.map(&:to_s).include?(action_name)))
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

  def grouped_properties_for_table table, options = {}
    options[:tier] ||= 3
    table.elements.map(&:property_id).tap do |property_ids|
      return grouped_options_for_select(([table.listable.model] + table.listable.model.belongs(options[:tier])).map do |model|
        [model.name, model.properties.map{ |property| ["#{model.name}##{property.name}", property.id] unless property_ids.include?(property.id) }.compact]
      end.reject do |grouped_options|
        grouped_options[1].blank?
      end)
    end
  end

  def grouped_properties_for_form form, options = {}
    options[:tier] ||= 3
    form.elements.map(&:property_id).tap do |property_ids|
      return grouped_options_for_select(([form.formable.model] + form.formable.model.belongs(options[:tier])).map do |model|
        [model.name, model.properties.map{ |property| ["#{model.name}##{property.name}", property.id] unless property_ids.include?(property.id) }.compact]
      end.reject do |grouped_options|
        grouped_options[1].blank?
      end)
    end
  end

  def grouped_properties_for_table_filter_scope table_filter
    table_filter.table.listable.model.tap do |model|
      table_filter.scopes.map(&:property).compact.tap do |properties|
        return grouped_options_for_select(([[model.name, model.properties.reject{ |property| property.is_a?(FileProperty) or property.is_a?(HashProperty) or property.type_array? }.map{ |property| ["#{model.name}##{property.name}", property.id] unless properties.map(&:id).include?(property.id) }.compact]] +
          model.belongs(1).map do |model|
            [model.name, model.properties.reject{ |property| property.is_a?(FileProperty) or property.is_a?(HashProperty) or property.type_array? }.map{ |property| ["#{model.name}##{property.name}", property.id] unless properties.map(&:model_id).include?(property.model_id) }.compact]
          end).reject do |grouped_options|
            grouped_options[1].blank?
          end)
      end
    end
  end
end
