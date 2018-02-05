class PresenceValidationsController < ApplicationController
  before_action :find_presence_validation, only: %w(show destroy)
  before_action :find_property, only: %w(create)

  def show
  end

  def create
    @property.create_presence_validation
    redirect_to @property.model, notice: notice_sentence
  end

  def destroy
    @presence_validation.destroy
    redirect_to @presence_validation.property.model, notice: notice_sentence
  end

  protected
    def find_presence_validation
      @presence_validation = PresenceValidation.find(params[:id])
    end

    def find_property
      @property = Property.find(params[:property_id])
    end
end
