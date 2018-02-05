# -*- encoding : utf-8 -*-
class PropertiesController < ApplicationController
  before_action :find_property, only: %w(destroy)
  before_action :find_model, only: %w(new create sort)

  def destroy
    @property.destroy!
    redirect_to @property.model, notice: notice_sentence
  end

  def sort
    if request.patch?
      Property.sort(params[:property_ids])
      head 200
    end
  end

  protected
    def find_property
      @property = Property.find(params[:id])
    end

    def find_model
      @model = @current_project.models.find(params[:model_id])
    end
end
