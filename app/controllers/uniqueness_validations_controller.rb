class UniquenessValidationsController < ApplicationController
  before_action :find_uniqueness_validation, only: %w(edit update destroy)
  before_action :find_property, only: %w(new create)
  before_action :format_array_attributes, only: %w(create update)

  def new
    @uniqueness_validation = @property.build_uniqueness_validation
  end

  def edit
  end

  def create
    @uniqueness_validation = @property.build_uniqueness_validation(uniqueness_validation_params)
    if @uniqueness_validation.save
      redirect_to @property.model, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @uniqueness_validation.update(uniqueness_validation_params)
      redirect_to @uniqueness_validation.property.model, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @uniqueness_validation.destroy
    redirect_to @uniqueness_validation.property.model, notice: notice_sentence
  end

  protected
    def uniqueness_validation_params
      params.require(:uniqueness_validation).permit!
    end

    def find_uniqueness_validation
      @uniqueness_validation = UniquenessValidation.find(params[:id])
    end

    def find_property
      @property = Property.find(params[:property_id])
    end

    def format_array_attributes
      uniqueness_validation_params[:scopes] = uniqueness_validation_params[:scopes].split(',')
    end
end
