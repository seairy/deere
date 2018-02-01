class ConfirmationValidationsController < ApplicationController
  before_action :find_confirmation_validation, only: %w(edit update destroy)
  before_action :find_property, only: %w(new create)

  def new
    @confirmation_validation = @property.build_confirmation_validation
  end

  def edit
  end

  def create
    @confirmation_validation = @property.build_confirmation_validation(confirmation_validation_params)
    if @confirmation_validation.save
      redirect_to @property.model, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @confirmation_validation.update(confirmation_validation_params)
      redirect_to @confirmation_validation.property.model, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @confirmation_validation.destroy
    redirect_to @confirmation_validation.property.model, notice: notice_sentence
  end

  protected
    def confirmation_validation_params
      params.require(:confirmation_validation).permit!
    end

    def find_confirmation_validation
      @confirmation_validation = ConfirmationValidation.find(params[:id])
    end

    def find_property
      @property = Property.find(params[:property_id])
    end
end
