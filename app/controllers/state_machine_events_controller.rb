class StateMachineEventsController < ApplicationController
  before_action :find_state_machine_event, only: %w(edit update destroy initial)
  before_action :find_state_machine, only: %w(new create)

  def new
    @state_machine_event = @state_machine.events.new
  end

  def create
    @state_machine_event = @state_machine.events.new(state_machine_event_params)
    if @state_machine_event.save
      redirect_to @state_machine, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @state_machine_event.update(state_machine_event_params)
      redirect_to @state_machine_event.state_machine, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @state_machine_event.destroy
    redirect_to @state_machine_event.state_machine, notice: notice_sentence
  end

  def initial
    @state_machine_event.update!(initial: true)
    redirect_to @state_machine_event.state_machine, notice: notice_sentence
  end

  def sort
    StateMachineEvent.sort(params[:state_machine_event_ids])
    head 200
  end

  protected
    def state_machine_event_params
      params.require(:state_machine_event).permit!
    end

    def find_state_machine_event
      @state_machine_event = StateMachineEvent.find(params[:id])
    end

    def find_state_machine
      @state_machine = StateMachine.find(params[:state_machine_id])
    end
end
