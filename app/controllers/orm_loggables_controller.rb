class OrmLoggablesController < ApplicationController
  before_action :find_orm_loggable, only: %w(edit update destroy)
  before_action :find_model, only: %w(new create)

  def new
    @orm_loggable = @model.build_orm_loggable
  end

  def edit
  end

  def create
    @orm_loggable = @model.build_orm_loggable(orm_loggable_params)
    if @orm_loggable.save
      redirect_to @model, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @orm_loggable.update(orm_loggable_params)
      redirect_to @orm_loggable.model, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @orm_loggable.destroy
    redirect_to @orm_loggable.model, notice: notice_sentence
  end

  protected
    def orm_loggable_params
      params.require(:orm_loggable).permit!
    end

    def find_orm_loggable
      @orm_loggable = OrmLoggable.find(params[:id])
    end

    def find_model
      @model = Model.find(params[:model_id])
    end
end
