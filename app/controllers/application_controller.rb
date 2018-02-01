class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate

  protected
    def authenticate
      @current_project = Project.find(session['project_id'])
    rescue ActiveRecord::RecordNotFound
      redirect_to sign_in_path 
    end

    def notice_sentence
      'Successful'
    end

    def alert_sentence
      'Failed'
    end
end
