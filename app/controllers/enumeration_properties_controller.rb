# -*- encoding : utf-8 -*-
class EnumerationPropertiesController < ApplicationController
  before_action :find_property, only: %w(edit update destroy)
  before_action :find_model, only: %w(new create)
  before_action :fix_enumeration_elements, only: %w(create)
  
  def new
    @property = @model.enumeration_properties.new
  end
  
  def edit
  end
  
  def create
    @property = @model.enumeration_properties.new(enumeration_property_params)
    if @property.save
      redirect_to @model, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @property.update(enumeration_property_params)
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
    def enumeration_property_params
      params.require(:enumeration_property).permit!
    end

    def fix_enumeration_elements
      enumeration_property_params[:elements_attributes].tap do |elements_attributes|
        elements_attributes.reject! do |id, elements_attribute|
          elements_attribute[:code].blank? or elements_attribute[:localized_name].blank? or elements_attribute[:name].blank?
        end
        %i(code name localized_name).each do |attribute_name|
          result = []
          elements_attributes.reject! do |id, elements_attribute|
            if result.include?(elements_attribute[attribute_name])
              true
            else
              result << elements_attribute[attribute_name]; false
            end
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
