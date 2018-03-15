class CustomValidationsController < ApplicationController
  before_action :find_custom_validation, only: %w(show edit update destroy)
  before_action :find_model, only: %w(new create)

  def show
  end

  def new
    @custom_validation = @model.custom_validations.new
  end

  def edit
  end

  def create
    @custom_validation = @model.custom_validations.new(custom_validation_params)
    if @custom_validation.save
      redirect_to @model, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @custom_validation.update(custom_validation_params)
      redirect_to @custom_validation.model, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @custom_validation.destroy
    redirect_to @custom_validation.model, notice: notice_sentence
  end

  protected
    def custom_validation_params
      params.require(:custom_validation).permit!
    end

    def find_custom_validation
      @custom_validation = CustomValidation.find(params[:id])
    end

    def find_model
      @model = Model.find(params[:model_id])
    end
end
