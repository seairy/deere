class MigrationsEngine < ApplicationEngine

  def compile
    @project.namespaces.each do |namespace|
      namespace.relevant_models.each do |model|
        @project.source_codes.create!(prefix: ["app", "controllers", namespace.module],
          file_name: "base_controller.rb",
          content: content_for(namespace))
        @project.source_codes.create!(prefix: ["app", "controllers", namespace.module],
          file_name: "#{model.code.pluralize}_controller.rb",
          content: content_for(namespace, model))
      end
    end
  end

  protected
    def content_for namespace, model = nil
      if model.present?
        "class #{namespace.module.camelize}::#{model.code.camelize}Controller < #{namespace.module.camelize}::BaseController\n" +
        [before_actions(namespace, model),
          actions(model),
          parameters(model),
          finders(model)].join("\n") +
        "end"
      else
        "class #{namespace.module.camelize}::BaseController < ApplicationController\n" +
        "end"
      end
    end

    def before_actions namespace, model
      [].tap do |result|
      end.join("\n")
    end

    def actions namespace, model
      [].tap do |result|
        
      end.join("\n")
    end

    def parameters namespace, model
      
    end

    def finders namespace, model

    end
end
