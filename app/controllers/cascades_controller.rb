class CascadesController < ApplicationController
  before_action :find_cascade, only: %w(edit update destroy)
  before_action :find_model, only: %w(as_source as_destination create)

  def as_source
    @cascade = @model.cascades_as_source.new
  end

  def as_destination
    @cascade = @model.cascades_as_destination.new
  end

  def edit
  end

  def create
    @cascade = Cascade.new(cascade_params)
    if @cascade.source.blank?
      @cascade.source = @model
    elsif @cascade.destination.blank?
      @cascade.destination = @model
    end
    if @cascade.save
      redirect_to @model, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @cascade.update(cascade_params)
      redirect_to @cascade.model, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @cascade.destroy
    redirect_to @cascade.model, notice: notice_sentence
  end

  protected
    def cascade_params
      params.require(:cascade).permit!
    end

    def find_cascade
      @cascade = Cascade.find(params[:id])
    end

    def find_model
      @model = Model.find(params[:model_id])
    end
end
