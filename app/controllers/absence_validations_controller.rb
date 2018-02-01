class AbsenceValidationsController < ApplicationController
  before_action :find_absence_validation, only: %w(edit update destroy)
  before_action :find_property, only: %w(new create)

  def new
    @absence_validation = @property.build_absence_validation
  end

  def edit
  end

  def create
    @absence_validation = @property.build_absence_validation(absence_validation_params)
    if @absence_validation.save
      redirect_to @property.model, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @absence_validation.update(absence_validation_params)
      redirect_to @absence_validation.property.model, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @absence_validation.destroy
    redirect_to @absence_validation.property.model, notice: notice_sentence
  end

  protected
    def absence_validation_params
      params.require(:absence_validation).permit!
    end

    def find_absence_validation
      @absence_validation = AbsenceValidation.find(params[:id])
    end

    def find_property
      @property = Property.find(params[:property_id])
    end
end
