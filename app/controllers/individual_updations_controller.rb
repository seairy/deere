class IndividualUpdationsController < ApplicationController
  before_action :find_individual_updation, only: %w(show edit update destroy)
  before_action :find_resourceful_controller, only: %w(new create)

  def show
  end

  def new
    @individual_updation = @resourceful_controller.individual_updations.new(frontend_action_name: "edit", backend_action_name: "update", backend_action_method: "patch", confirmable: false)
  end

  def edit
  end

  def create
    @individual_updation = @resourceful_controller.individual_updations.new(individual_updation_params)
    if @individual_updation.save
      redirect_to @individual_updation, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @individual_updation.update(individual_updation_params)
      redirect_to @individual_updation, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @individual_updation.destroy
    redirect_to @individual_updation.resourceful_controller, notice: notice_sentence
  end

  protected
    def individual_updation_params
      params.require(:individual_updation).permit!
    end

    def find_individual_updation
      @individual_updation = IndividualUpdation.find(params[:id])
    end

    def find_resourceful_controller
      @resourceful_controller = ResourcefulController.find(params[:resourceful_controller_id])
    end
end
