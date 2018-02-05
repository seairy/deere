class AbsenceValidationsController < ApplicationController
  before_action :find_absence_validation, only: %w(show destroy)
  before_action :find_property, only: %w(create)

  def show
  end

  def create
    @property.create_absence_validation
    redirect_to @property.model, notice: notice_sentence
  end

  def destroy
    @absence_validation.destroy
    redirect_to @absence_validation.property.model, notice: notice_sentence
  end

  protected
    def find_absence_validation
      @absence_validation = AbsenceValidation.find(params[:id])
    end

    def find_property
      @property = Property.find(params[:property_id])
    end
end
