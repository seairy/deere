# -*- encoding : utf-8 -*-
class PropertiesController < ApplicationController
  before_action :find_property, only: %w(show edit update destroy)
  before_action :find_model, only: %w(new create)
  
  def show
  end
  
  def new
    @property = @model.properties.new
  end
  
  def edit
  end
  
  def create
    @property = @model.properties.new(property_params)
    if @property.save
      redirect_to @property, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @property.update(property_params)
      redirect_to @property, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @property.destroy!
    redirect_to properties_path, notice: notice_sentence
  end

  protected
    def property_params
      params.require(:property).permit!
    end

    def find_property
      @property = Property.find(params[:id])
    end

    def find_model
      @model = @current_project.models.find(params[:model_id])
    end
end
