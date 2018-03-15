class CascadesController < ApplicationController
  before_action :find_cascade, only: %w(show edit update destroy)
  before_action :find_model, only: %w(as_source as_destination create_as_source create_as_destination)

  def show
    @available_models_for_cascade_redundancy = @cascade.source.belongs(3).reject{|model| @cascade.redundancies.map(&:model_id).include?(model.id)}
  end

  def as_source
    @cascade = @model.cascades_as_source.new
  end

  def as_destination
    @cascade = @model.cascades_as_destination.new
  end

  def edit
  end

  def create_as_source
    @cascade = Cascade.new(cascade_params.merge(source: @model))
    if @cascade.save
      redirect_to @model, notice: notice_sentence
    else
      render action: 'as_source'
    end
  end

  def create_as_destination
    @cascade = Cascade.new(cascade_params.merge(destination: @model))
    if @cascade.save
      redirect_to @model, notice: notice_sentence
    else
      render action: 'as_destination'
    end
  end

  def update
    if @cascade.update(cascade_params)
      redirect_to cascade_path(@cascade, from: params[:from]), notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @cascade.destroy
    redirect_to (case params[:from]
    when 'source' then @cascade.source
    when 'destination' then @cascade.destination
    end), notice: notice_sentence
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
