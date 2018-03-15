# -*- encoding : utf-8 -*-
class FilePropertiesController < ApplicationController
  before_action :find_property, only: %w(edit update destroy)
  before_action :find_model, only: %w(new create)
  
  def new
    @property = @model.file_properties.new
  end
  
  def edit
  end
  
  def create
    @property = @model.file_properties.new(file_property_params)
    if @property.save
      redirect_to @model, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @property.update(file_property_params)
      redirect_to @property.model, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @property.destroy!
    redirect_to properties_path, notice: notice_sentence
  end

  protected
    def file_property_params
      params.require(:file_property).permit!
    end

    def find_property
      @property = Property.find(params[:id])
    end

    def find_model
      @model = @current_project.models.find(params[:model_id])
    end
end
