class RoutesEngine < ApplicationEngine

  def compile
    @project.source_codes.create!(prefix: ["config"],
      file_name: "routes",
      extension: "rb",
      content: statements)
  end

  protected
    def statements
      [].tap do |result|
        @project.namespaces.each do |namespace|
          result << "Rails.application.routes.draw do"
          result << "scope as: :#{namespace.name}, module: :#{namespace.module}, path: :#{namespace.path} do"
          namespace.resourceful_controllers.each do |resourceful_controller|
            result << "resources :#{resourceful_controller.model.code.pluralize}"
          end
          result << "end"
          result << ""
          result << "end"
        end
      end.join("\n")
    end
end
