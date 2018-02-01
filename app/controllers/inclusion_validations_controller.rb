class InclusionValidationsController < ApplicationController
  before_action :find_inclusion_validation, only: %w(edit update destroy)
  before_action :find_property, only: %w(new create)
  before_action :format_array_attributes, only: %w(create update)

  def new
    @inclusion_validation = @property.build_inclusion_validation
  end

  def edit
  end

  def create
    @inclusion_validation = @property.build_inclusion_validation(inclusion_validation_params)
    if @inclusion_validation.save
      redirect_to @property.model, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @inclusion_validation.update(inclusion_validation_params)
      redirect_to @inclusion_validation.property.model, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @inclusion_validation.destroy
    redirect_to @inclusion_validation.property.model, notice: notice_sentence
  end

  protected
    def inclusion_validation_params
      params.require(:inclusion_validation).permit!
    end

    def find_inclusion_validation
      @inclusion_validation = InclusionValidation.find(params[:id])
    end

    def find_property
      @property = Property.find(params[:property_id])
    end

    def format_array_attributes
      inclusion_validation_params[:values] = inclusion_validation_params[:values].split(',')
    end
end
