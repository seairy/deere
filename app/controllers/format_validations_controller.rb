class FormatValidationsController < ApplicationController
  before_action :find_format_validation, only: %w(edit update destroy)
  before_action :find_property, only: %w(new create)

  def new
    @format_validation = @property.build_format_validation
  end

  def edit
  end

  def create
    @format_validation = @property.build_format_validation(format_validation_params)
    if @format_validation.save
      redirect_to @property.model, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @format_validation.update(format_validation_params)
      redirect_to @format_validation.property.model, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @format_validation.destroy
    redirect_to @format_validation.property.model, notice: notice_sentence
  end

  protected
    def format_validation_params
      params.require(:format_validation).permit!
    end

    def find_format_validation
      @format_validation = FormatValidation.find(params[:id])
    end

    def find_property
      @property = Property.find(params[:property_id])
    end
end
