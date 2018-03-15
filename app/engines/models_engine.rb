class ModelsEngine < ApplicationEngine

  def compile
    @project.models.each do |model|
      @project.source_codes.create!(prefix: ["app", "models"],
        file_name: "#{model.code}.rb",
        content: content_for(model))
    end
  end

  protected
    def content_for model
      "class #{model.code.camelize} < ApplicationRecord\n" +
      [extensions(model),
        inclusions(model),
        enumerations(model),
        associations(model),
        scopes(model),
        validations(model),
        class_methods(model),
        instance_methods(model)].join("\n") +
      "end"
    end

    def extensions model
      [].tap do |result|
        model.extends_classes.each do |class_name|
          result << "extend #{class_name}"
        end
        result << "extend Enumerize" if model.enumeration_properties.present?
      end.join("\n")
    end

    def inclusions model
      [].tap do |result|
        model.includes_classes.each do |class_name|
          result << "include #{class_name}"
        end
      end.join("\n")
    end

    def enumerations model
      [].tap do |result|
        model.enumeration_properties.each do |enumeration_property|
          result << "enumerize :#{enumeration_property.code}, in: %w(#{enumeration_property.elements.order(:position).map{ |enumeration_element| enumeration_element.code }.join(" ")}), predicates: { prefix: true }, scope: true"
        end
      end.join("\n")
    end

    def associations model
      [].tap do |result|
        model.cascades_as_destination.each do |cascade|
          result << ([].tap do |line|
            if cascade.source_alias.present?
              line << "belongs_to :#{cascade.source_alias}"
              line << "class_name: \"#{cascade.source.code.camelize}\""
              line << "foreign_key: \"#{cascade.source.code}_id\""
            else
              line << "belongs_to :#{cascade.source.code}"
            end
            line << "optional: true" if cascade.optional?
            case cascade.action_when_child_destroyed
            when "destroy" then line << "dependent: :destroy"
            when "delete" then line << "dependent: :delete"
            end
          end.join(", "))
        end
        model.cascades_as_source.each do |cascade|
          result << ([].tap do |line|
            if cascade.destination_alias.present?
              line << "#{cascade.type} :#{cascade.destination_alias}"
            else
              line << "#{cascade.type} :#{cascade.destination.code.pluralize}"
            end
            case cascade.action_when_owner_destroyed
            when "destroy" then line << "dependent: :destroy"
            when "delete"
              case cascade.type
              when "has_one" then line << "dependent: :delete"
              when "has_many" then line << "dependent: :delete_all"
              end
            when "nullify" then line << "dependent: :nullify"
            when "restrict_with_exception" then line << "dependent: :restrict_with_exception"
            when "restrict_with_error" then line << "dependent: :restrict_with_error"
            end
          end.join(", "))
        end
      end.join("\n")
    end

    def scopes model
      ""
    end

    def validations model
      [].tap do |result|
        model.properties.each do |property|
          result << ([].tap do |line|
            line << "validates :#{property.code}"
            line << "acceptance: true" if property.acceptance_validation.present?
            line << "confirmation: true" if property.confirmation_validation.present?
            line << "exclusion: { in: %w(property.exclusion_validation.values.join(" ")) }" if property.exclusion_validation.present?
            line << "format: { with: /#{property.format_validation.regular_expression}/ }" if property.format_validation.present?
            line << "inclusion: { in: %w(property.inclusion_validation.values.join(" ")) }" if property.inclusion_validation.present?
            if property.length_validation.present?
              if property.length_validation.minimum == property.length_validation.maximum
                line << "length: { is: #{property.length_validation.minimum} }"
              elsif property.length_validation.minimum.present? and property.length_validation.maximum.present?
                line << "length: { in: #{property.length_validation.minimum}..#{property.length_validation.maximum} }"
              elsif property.length_validation.minimum.present?
                line << "length: { minimum: #{property.length_validation.minimum} }"
              elsif property.length_validation.maximum.present?
                line << "length: { maximum: #{property.length_validation.maximum} }"
              end
            end
            if property.numericality_validation.present?
              if property.numericality_validation.minimum.blank? and property.numericality_validation.maximum.blank? and !property.numericality_validation.only_integer?
                line << "numericality: true"
              else
                line << "numericality: { " +
                [].tap do |options|
                  options << "only_integer: true" if property.numericality_validation.only_integer?
                  if property.numericality_validation.minimum.present? and property.numericality_validation.maximum.present? and property.numericality_validation.minimum == property.numericality_validation.maximum
                    options << "equal_to: #{property.numericality_validation.minimum}"
                  elsif property.numericality_validation.minimum.present?
                    if property.numericality_validation.includes_minimum.present?
                      options << "greater_than_or_equal_to: #{property.numericality_validation.minimum}"
                    else
                      options << "greater_than: #{property.numericality_validation.minimum}"
                    end
                  elsif property.numericality_validation.maximum.present?
                    if property.numericality_validation.includes_maximum.present?
                      options << "less_than_or_equal_to: #{property.numericality_validation.maximum}"
                    else
                      options << "less_than: #{property.numericality_validation.maximum}"
                    end
                  end
                end.join(", ") +
                " }"
              end
            end
            line << "presence: true" if property.presence_validation.present?
            line << "absence: true" if property.absence_validation.present?
            if property.uniqueness_validation.present?
              if property.uniqueness_validation.scopes.present?
                line << "uniqueness: { scope: %w(#{property.uniqueness_validation.scopes.join(" ")}) }"
              else
                line << "uniqueness: true"
              end
            end
          end.join(", ")) if property.any_validation?
        end
      end.join("\n")
    end

    def class_methods model
      ""
    end

    def instance_methods model
      ""
    end
end
