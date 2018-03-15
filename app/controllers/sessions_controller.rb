class SessionsController < ApplicationController
  skip_before_action :authenticate
  layout null: true

  def new
  end

  def create
    session['project_id'] = params[:project][:id]
    redirect_to models_path
  end

  def destroy
    session['project_id'] = nil
    redirect_to sign_in_path
  end
end
