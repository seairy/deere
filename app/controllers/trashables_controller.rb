class TrashablesController < ApplicationController
  before_action :find_trashable, only: %w(edit update destroy)
  before_action :find_model, only: %w(new create)

  def new
    @trashable = @model.build_trashable
  end

  def edit
  end

  def create
    @trashable = @model.build_trashable(trashable_params)
    if @trashable.save
      redirect_to @model, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @trashable.update(trashable_params)
      redirect_to @trashable.model, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @trashable.destroy
    redirect_to @trashable.model, notice: notice_sentence
  end

  protected
    def trashable_params
      params.require(:trashable).permit!
    end

    def find_trashable
      @trashable = Trashable.find(params[:id])
    end

    def find_model
      @model = Model.find(params[:model_id])
    end
end
