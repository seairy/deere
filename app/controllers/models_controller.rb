# -*- encoding : utf-8 -*-
class ModelsController < ApplicationController
  before_action :find_model, only: %w(show edit update destroy)
  before_action :format_array_attributes, only: %w(create update)
  
  def index
    @models = @current_project.models.all
  end
  
  def show
    @properties = @model.properties.includes(:common_validation, :acceptance_validation, :confirmation_validation, :exclusion_validation, :format_validation, :inclusion_validation, :length_validation, :numericality_validation, :presence_validation, :absence_validation, :uniqueness_validation)
  end
  
  def new
    @model = @current_project.models.new
  end
  
  def edit
  end
  
  def create
    @model = @current_project.models.new(model_params)
    if @model.save
      redirect_to @model, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @model.update(model_params)
      redirect_to @model, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @model.destroy!
    redirect_to models_path, notice: notice_sentence
  end

  protected
    def model_params
      params.require(:model).permit!
    end

    def find_model
      @model = Model.find(params[:id])
    end

    def format_array_attributes
      model_params[:includes_classes] = model_params[:includes_classes].split(',')
      model_params[:extends_classes] = model_params[:extends_classes].split(',')
    end
end
