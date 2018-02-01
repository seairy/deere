class LengthValidationsController < ApplicationController
  before_action :find_length_validation, only: %w(edit update destroy)
  before_action :find_property, only: %w(new create)

  def new
    @length_validation = @property.build_length_validation
  end

  def edit
  end

  def create
    @length_validation = @property.build_length_validation(length_validation_params)
    if @length_validation.save
      redirect_to @property.model, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @length_validation.update(length_validation_params)
      redirect_to @length_validation.property.model, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @length_validation.destroy
    redirect_to @length_validation.property.model, notice: notice_sentence
  end

  protected
    def length_validation_params
      params.require(:length_validation).permit!
    end

    def find_length_validation
      @length_validation = LengthValidation.find(params[:id])
    end

    def find_property
      @property = Property.find(params[:property_id])
    end
end
