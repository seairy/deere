class I18nEngine < ApplicationEngine
  def compile
    @project.source_codes.create!(prefix: ["config", "locales"],
      file_name: "#{@project.primary_language}",
      extension: "yml",
      content: locale_file)
  end

  protected
    def locale_file
      [template.read,
        enumerizes,
        models,
        attributes
      ].join("\n")
    end

    def template
      File.open(File.join(Rails.root, "app", "templates", "locales", "#{@project.primary_language}.yml"))
    end

    def enumerizes
      [].tap do |result|
        if (enumeration_properties = @project.models.map(&:enumeration_properties).compact.flatten).present?
          result << "  enumerize:"
          enumeration_properties.each do |enumeration_property|
            result << "    #{enumeration_property.model.code}:"
            result << "      #{enumeration_property.code}:"
            enumeration_property.elements.each do |enumeration_element|
              result << "        #{enumeration_element.code}: #{enumeration_element.name}"
            end
          end
        end
      end.join("\n")
    end

    def models
      [].tap do |result|
        result << "  activerecord:"
        if (models = @project.models).present?
          result << "    models:"
          models.each do |model|
            result << "      #{model.code}: #{model.name}"
          end
        end
      end.join("\n")
    end

    def attributes
      [].tap do |result|
        if (models = @project.models).present?
          result << "  attributes:"
          models.each do |model|
            result << "    #{model.code}:"
            model.properties.order(:position).each do |property|
              result << "      #{property.code}: #{property.name}"
            end
          end
        end
      end.join("\n")
    end
end
