class SortablesController < ApplicationController
  before_action :find_sortable, only: %w(edit update destroy)
  before_action :find_model, only: %w(new create)

  def new
    @sortable = @model.build_sortable
  end

  def edit
  end

  def create
    @sortable = @model.build_sortable(sortable_params)
    if @sortable.save
      redirect_to @model, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @sortable.update(sortable_params)
      redirect_to @sortable.model, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @sortable.destroy
    redirect_to @sortable.model, notice: notice_sentence
  end

  protected
    def sortable_params
      params.require(:sortable).permit!
    end

    def find_sortable
      @sortable = Sortable.find(params[:id])
    end

    def find_model
      @model = Model.find(params[:model_id])
    end
end
