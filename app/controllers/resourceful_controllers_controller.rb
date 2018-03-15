# -*- encoding : utf-8 -*-
class ResourcefulControllersController < ApplicationController
  before_action :find_resourceful_controller, only: %w(show edit update destroy)
  
  def index
    @resourceful_controllers = @current_project.resourceful_controllers.all
  end
  
  def show
  end
  
  def new
    @resourceful_controller = ResourcefulController.new
  end
  
  def edit
  end
  
  def create
    @resourceful_controller = ResourcefulController.new(resourceful_controller_params)
    if @resourceful_controller.save
      redirect_to @resourceful_controller, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @resourceful_controller.update(resourceful_controller_params)
      redirect_to @resourceful_controller, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @resourceful_controller.destroy!
    redirect_to resourceful_controllers_path, notice: notice_sentence
  end

  protected
    def resourceful_controller_params
      params.require(:resourceful_controller).permit!
    end

    def find_resourceful_controller
      @resourceful_controller = ResourcefulController.find(params[:id])
    end
end
