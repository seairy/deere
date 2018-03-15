class SubmodelsController < ApplicationController
  before_action :find_submodel, only: %w(edit update destroy)
  before_action :find_model, only: %w(new create)

  def new
    @submodel = @model.submodels.new
  end

  def edit
  end

  def create
    @submodel = @model.submodels.new(submodel_params)
    if @submodel.save
      redirect_to @model, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @submodel.update(submodel_params)
      redirect_to @submodel.model, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @submodel.destroy
    redirect_to @submodel.model, notice: notice_sentence
  end

  protected
    def submodel_params
      params.require(:submodel).permit!
    end

    def find_submodel
      @submodel = Submodel.find(params[:id])
    end

    def find_model
      @model = Model.find(params[:model_id])
    end
end
