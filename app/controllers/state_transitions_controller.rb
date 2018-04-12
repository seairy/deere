class StateTransitionsController < ApplicationController
  before_action :find_state_transition, only: %w(show edit update destroy)
  before_action :find_resourceful_controller, only: %w(new create)

  def show
  end

  def new
    @state_transition = @resourceful_controller.state_transitions.new(action_method: :patch, confirmable: false)
  end

  def edit
  end

  def create
    @state_transition = @resourceful_controller.state_transitions.new(state_transition_params)
    if @state_transition.save
      redirect_to @state_transition, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @state_transition.update(state_transition_params)
      redirect_to @state_transition, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @state_transition.destroy
    redirect_to @state_transition.resourceful_controller, notice: notice_sentence
  end

  protected
    def state_transition_params
      params.require(:state_transition).permit!
    end

    def find_state_transition
      @state_transition = StateTransition.find(params[:id])
    end

    def find_resourceful_controller
      @resourceful_controller = ResourcefulController.find(params[:resourceful_controller_id])
    end
end
