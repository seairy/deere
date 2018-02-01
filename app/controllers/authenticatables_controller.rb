class AuthenticatablesController < ApplicationController
  before_action :find_authenticatable, only: %w(edit update destroy)
  before_action :find_model, only: %w(new create)

  def new
    @authenticatable = @model.build_authenticatable
  end

  def edit
  end

  def create
    @authenticatable = @model.build_authenticatable(authenticatable_params)
    if @authenticatable.save
      redirect_to @model, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @authenticatable.update(authenticatable_params)
      redirect_to @authenticatable.model, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @authenticatable.destroy
    redirect_to @authenticatable.model, notice: notice_sentence
  end

  protected
    def authenticatable_params
      params.require(:authenticatable).permit!
    end

    def find_authenticatable
      @authenticatable = Authenticatable.find(params[:id])
    end

    def find_model
      @model = Model.find(params[:model_id])
    end
end
