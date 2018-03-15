# -*- encoding : utf-8 -*-
class HashPropertiesController < ApplicationController
  before_action :find_property, only: %w(edit update destroy)
  before_action :find_model, only: %w(new create)
  before_action :fix_serialized_hashes, only: %w(create)
  
  def new
    @property = @model.hash_properties.new
  end
  
  def edit
  end
  
  def create
    @property = @model.hash_properties.new(hash_property_params)
    if @property.save
      redirect_to @model, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @property.update(hash_property_params)
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
    def hash_property_params
      params.require(:hash_property).permit!
    end

    def fix_serialized_hashes
      hash_property_params[:serialized_hashes_attributes].tap do |serialized_hashes_attributes|
        serialized_hashes_attributes.reject! do |id, serialized_hashes_attribute|
          serialized_hashes_attribute[:name].blank?
        end
        result = []
        serialized_hashes_attributes.reject! do |id, serialized_hashes_attribute|
          if result.include?(serialized_hashes_attribute[:name])
            true
          else
            result << serialized_hashes_attribute[:name]; false
          end
        end
      end
    end

    def find_property
      @property = Property.find(params[:id])
    end

    def find_model
      @model = @current_project.models.find(params[:model_id])
    end
end
