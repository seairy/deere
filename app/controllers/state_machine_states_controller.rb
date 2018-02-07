class StateMachineStatesController < ApplicationController
  before_action :find_state_machine_state, only: %w(edit update destroy initial)
  before_action :find_state_machine, only: %w(new create)

  def new
    @state_machine_state = @state_machine.states.new
  end

  def create
    @state_machine_state = @state_machine.states.new(state_machine_state_params)
    if @state_machine_state.save
      redirect_to @state_machine, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @state_machine_state.update(state_machine_state_params)
      redirect_to @state_machine_state.state_machine, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @state_machine_state.destroy
    redirect_to @state_machine_state.state_machine, notice: notice_sentence
  end

  def initial
    @state_machine_state.update!(initial: true)
    redirect_to @state_machine_state.state_machine, notice: notice_sentence
  end

  def sort
    StateMachineState.sort(params[:state_machine_state_ids])
    head 200
  end

  protected
    def state_machine_state_params
      params.require(:state_machine_state).permit!
    end

    def find_state_machine_state
      @state_machine_state = StateMachineState.find(params[:id])
    end

    def find_state_machine
      @state_machine = StateMachine.find(params[:state_machine_id])
    end
end
