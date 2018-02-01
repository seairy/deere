class PresenceValidationsController < ApplicationController
  before_action :find_presence_validation, only: %w(edit update destroy)
  before_action :find_property, only: %w(new create)

  def new
    @presence_validation = @property.build_presence_validation
  end

  def edit
  end

  def create
    @presence_validation = @property.build_presence_validation(presence_validation_params)
    if @presence_validation.save
      redirect_to @property.model, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @presence_validation.update(presence_validation_params)
      redirect_to @presence_validation.property.model, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @presence_validation.destroy
    redirect_to @presence_validation.property.model, notice: notice_sentence
  end

  protected
    def presence_validation_params
      params.require(:presence_validation).permit!
    end

    def find_presence_validation
      @presence_validation = PresenceValidation.find(params[:id])
    end

    def find_property
      @property = Property.find(params[:property_id])
    end
end
