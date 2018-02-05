class ExclusionValidationsController < ApplicationController
  before_action :find_exclusion_validation, only: %w(show edit update destroy)
  before_action :find_property, only: %w(new create)
  before_action :format_array_attributes, only: %w(create update)

  def show
  end

  def new
    @exclusion_validation = @property.build_exclusion_validation
  end

  def edit
  end

  def create
    @exclusion_validation = @property.build_exclusion_validation(exclusion_validation_params)
    if @exclusion_validation.save
      redirect_to @property.model, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @exclusion_validation.update(exclusion_validation_params)
      redirect_to @exclusion_validation.property.model, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @exclusion_validation.destroy
    redirect_to @exclusion_validation.property.model, notice: notice_sentence
  end

  protected
    def exclusion_validation_params
      params.require(:exclusion_validation).permit!
    end

    def find_exclusion_validation
      @exclusion_validation = ExclusionValidation.find(params[:id])
    end

    def find_property
      @property = Property.find(params[:property_id])
    end

    def format_array_attributes
      exclusion_validation_params[:values] = exclusion_validation_params[:values].split(',')
    end
end
