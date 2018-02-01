# -*- encoding : utf-8 -*-
class ProjectsController < ApplicationController
  skip_before_action :authenticate, only: %w(new create)
  before_action :find_project, only: %w(edit update destroy)
  
  def new
    @project = Project.new
  end
  
  def edit
  end
  
  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @project.update(project_params)
      redirect_to @project, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @project.destroy!
    redirect_to projects_path, notice: notice_sentence
  end

  def current
  end

  protected
    def project_params
      params.require(:project).permit!
    end

    def find_project
      @project = Project.find(params[:id])
    end
end
