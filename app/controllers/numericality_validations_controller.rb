class NumericalityValidationsController < ApplicationController
  before_action :find_numericality_validation, only: %w(edit update destroy)
  before_action :find_property, only: %w(new create)

  def new
    @numericality_validation = @property.build_numericality_validation
  end

  def edit
  end

  def create
    @numericality_validation = @property.build_numericality_validation(numericality_validation_params)
    if @numericality_validation.save
      redirect_to @property.model, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @numericality_validation.update(numericality_validation_params)
      redirect_to @numericality_validation.property.model, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @numericality_validation.destroy
    redirect_to @numericality_validation.property.model, notice: notice_sentence
  end

  protected
    def numericality_validation_params
      params.require(:numericality_validation).permit!
    end

    def find_numericality_validation
      @numericality_validation = NumericalityValidation.find(params[:id])
    end

    def find_property
      @property = Property.find(params[:property_id])
    end
end
