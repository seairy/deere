class StateMachinesController < ApplicationController
  before_action :find_state_machine, only: %w(show destroy)
  before_action :find_model, only: %w(create)

  def show
  end

  def create
    redirect_to @model.create_state_machine!, notice: notice_sentence
  end

  def destroy
    @state_machine.destroy
    redirect_to @state_machine.model, notice: notice_sentence
  end

  protected
    def state_machine_params
      params.require(:state_machine).permit!
    end

    def find_state_machine
      @state_machine = StateMachine.find(params[:id])
    end

    def find_model
      @model = Model.find(params[:model_id])
    end
end
