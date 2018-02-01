class AcceptanceValidationsController < ApplicationController
  before_action :find_acceptance_validation, only: %w(edit update destroy)
  before_action :find_property, only: %w(new create)

  def new
    @acceptance_validation = @property.build_acceptance_validation
  end

  def edit
  end

  def create
    @acceptance_validation = @property.build_acceptance_validation(acceptance_validation_params)
    if @acceptance_validation.save
      redirect_to @property.model, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @acceptance_validation.update(acceptance_validation_params)
      redirect_to @acceptance_validation.property.model, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @acceptance_validation.destroy
    redirect_to @acceptance_validation.property.model, notice: notice_sentence
  end

  protected
    def acceptance_validation_params
      params.require(:acceptance_validation).permit!
    end

    def find_acceptance_validation
      @acceptance_validation = AcceptanceValidation.find(params[:id])
    end

    def find_property
      @property = Property.find(params[:property_id])
    end
end
