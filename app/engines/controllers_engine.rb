class ControllersEngine < ApplicationEngine

  def compile
    @project.namespaces.each do |namespace|
      @project.source_codes.create!(prefix: ["app", "controllers", namespace.module],
        file_name: "base_controller",
        extension: "rb",
        content: base_controller(namespace))
      @project.source_codes.create!(prefix: ["app", "controllers", namespace.module],
        file_name: "sessions_controller",
        extension: "rb",
        content: sessions_controller(namespace))
      namespace.resourceful_controllers.each do |resourceful_controller|
        @project.source_codes.create!(prefix: ["app", "controllers", namespace.module],
          file_name: "#{resourceful_controller.model.code.pluralize}_controller",
          extension: "rb",
          content: content_for(namespace, resourceful_controller))
      end
    end
  end

  protected
    def base_controller namespace
      "class #{namespace.module.camelize}::BaseController < ApplicationController
        layout \"#{namespace.module}\"
        before_action :authenticate

        unless Rails.application.config.consider_all_requests_local
          rescue_from Exception, with: lambda { |exception| render_error 500, exception }
          rescue_from ActionController::RoutingError, ActionController::UnknownController, ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound, with: lambda { |exception| render_error 404, exception }
          rescue_from CanCan::AccessDenied, with: lambda { |exception| render_error 403, exception }
        end

        protected

        def render_error status, exception
          @service_exception = ServiceException.raise(module: :#{namespace.module}, exception: exception)
          render template: \"#{namespace.module}/errors/error_\#{status}\", status: status
        end

        def authenticate
          @current_#{namespace.authenticator.code} = Administrator.find(session.dig(\"#{namespace.authenticator.code}\", \"id\"))
        rescue ActiveRecord::RecordNotFound
          redirect_to #{namespace.name}_sign_in_path 
        end

        def current_user
          @current_#{namespace.authenticator.code}
        end
      end"
    end

    def sessions_controller namespace
      "class SessionsController < #{namespace.module.camelize}::BaseController
        skip_before_action :authenticate
        layout null: true

        def new
        end

        def create
          #{namespace.authenticator.code.camelize}.authenticate(#{namespace.authenticator.authenticatable.account_name}: params[:#{namespace.authenticator.authenticatable.account_name}], password: params[:password]).tap do |#{namespace.authenticator.code}|
            session[\"#{namespace.authenticator.code}\"] = { id: #{namespace.authenticator.code}.id }
            redirect_to #{namespace.name}_root_path
          end
        rescue AccountDoesNotExist
          redirect_to #{namespace.name}_sign_in_path, alert: t(\"error_messages.account_does_not_exist\")
        rescue IncorrectPassword
          redirect_to #{namespace.name}_sign_in_path(#{namespace.authenticator.authenticatable.account_name}: params[:#{namespace.authenticator.authenticatable.account_name}]), alert: t(\"error_messages.incorrect_password\")
        end

        def destroy
          session[\"#{namespace.authenticator.code}_id\"] = nil
          redirect_to sign_in_path
        end
      end"
    end

    def content_for namespace, resourceful_controller = nil
      "class #{namespace.module.camelize}::#{resourceful_controller.model.code.pluralize.camelize}Controller < #{namespace.module.camelize}::BaseController\n" +
      [callbacks(resourceful_controller),
        actions(resourceful_controller),
        "protected",
        parameters(resourceful_controller),
        finders(resourceful_controller)].join("\n") + "\n" +
      "end"
    end

    def callbacks resourceful_controller
      [].tap do |result|
        if resourceful_controller.retrieve_element.present? or resourceful_controller.individual_updation.present? or resourceful_controller.individual_deletion.present?
          result << "before_action :find_#{resourceful_controller.model.code}"
        end
      end.join("\n")
    end

    def actions resourceful_controller
      [].tap do |result|
        resourceful_controller.retrieve_collections.each do |retrieve_collection|
          result << "def #{retrieve_collection.action_code}"
          statement = "@#{resourceful_controller.model.code.pluralize} = #{resourceful_controller.model.code.camelize}"
          if (table_pagination = retrieve_collection.table.pagination).present?
            statement << ".page(params[:page]).per_page(#{table_pagination.per_page})"
          else
            statement << ".all"
          end
          result << statement
          result << "end"
        end
        if (retrieve_element = resourceful_controller.retrieve_element).present?
          result << "def show"
          result << "end"
        end
        if (individual_creation = resourceful_controller.individual_creation).present?
          result << "def new"
          result << "@#{resourceful_controller.model.code} = #{resourceful_controller.model.code.camelize}.new"
          result << "end"
        end
        if (individual_updation = resourceful_controller.individual_updation).present?
          result << "def edit"
          result << "end"
        end
        if (individual_creation = resourceful_controller.individual_creation).present?
          result << "def create"
          result << "@#{resourceful_controller.model.code} = #{resourceful_controller.model.code.camelize}.new(#{resourceful_controller.model.code}_params)"
          result << "if @#{resourceful_controller.model.code}.save"
          result << "redirect_to [:#{resourceful_controller.namespace.name}, @#{resourceful_controller.model.code}], notice: notice_prompt"
          result << "else"
          result << "render action: \"new\""
          result << "end"
          result << "end"
        end
        if (individual_updation = resourceful_controller.individual_updation).present?
          result << "def update"
          result << "if @#{resourceful_controller.model.name}.update(#{resourceful_controller.model.code}_params)"
          result << "redirect_to [:#{resourceful_controller.namespace.name}, @#{resourceful_controller.model.name}], notice: notice_prompt"
          result << "else"
          result << "render action: \"edit\""
          result << "end"
          result << "end"
        end
        resourceful_controller.state_transitions.each do |state_transition|
          result << "def #{state_transition.action_code}"
          result << "@#{resourceful_controller.model.code}!"
          result << "redirect_to [:#{resourceful_controller.namespace.name}, @#{resourceful_controller.model.code}], notice: notice_prompt"
          result << "end"
        end
        if (individual_deletion = resourceful_controller.individual_deletion).present?
          result << "def destroy"
          result << "@#{resourceful_controller.model.code}.destroy!"
          result << "redirect_to #{resourceful_controller.namespace.name}_#{resourceful_controller.model.code.pluralize}_path, notice: notice_prompt"
          result << "end"
        end
      end.join("\n")
    end

    def parameters resourceful_controller
      [].tap do |result|
        if resourceful_controller.individual_creation.present? or resourceful_controller.individual_updation.present?
          result << "def #{resourceful_controller.model.code}_params"
          result << "params.require(:#{resourceful_controller.model.code}).permit!"
          result << "end"
        end
      end.join("\n")
    end

    def finders resourceful_controller
      [].tap do |result|
        if resourceful_controller.retrieve_element.present? or resourceful_controller.individual_updation.present? or resourceful_controller.individual_deletion.present?
          result << "def find_#{resourceful_controller.model.code}"
          result << "@#{resourceful_controller.model.code} = #{resourceful_controller.model.code.camelize}.find(params[:id])"
          result << "end"
        end
      end.join("\n")
    end
end
