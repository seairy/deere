# -*- encoding : utf-8 -*-
class NamespacesController < ApplicationController
  before_action :find_namespace, only: %w(show edit update destroy)
  
  def index
    @namespaces = @current_project.namespaces.all
  end
  
  def show
  end
  
  def new
    @namespace = @current_project.namespaces.new
  end
  
  def edit
  end
  
  def create
    @namespace = @current_project.namespaces.new(namespace_params)
    if @namespace.save
      redirect_to @namespace, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @namespace.update(namespace_params)
      redirect_to @namespace, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @namespace.destroy!
    redirect_to namespaces_path, notice: notice_sentence
  end

  protected
    def namespace_params
      params.require(:namespace).permit!
    end

    def find_namespace
      @namespace = @current_project.namespaces.find(params[:id])
    end
end
