class IndividualCreationsController < ApplicationController
  before_action :find_individual_creation, only: %w(show edit update destroy)
  before_action :find_resourceful_controller, only: %w(new create)

  def show
  end

  def new
    @individual_creation = @resourceful_controller.build_individual_creation(confirmable: false)
  end

  def edit
  end

  def create
    @individual_creation = @resourceful_controller.build_individual_creation(individual_creation_params)
    if @individual_creation.save
      redirect_to @individual_creation, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @individual_creation.update(individual_creation_params)
      redirect_to @individual_creation, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @individual_creation.destroy
    redirect_to @individual_creation.resourceful_controller, notice: notice_sentence
  end

  protected
    def individual_creation_params
      params.require(:individual_creation).permit!
    end

    def find_individual_creation
      @individual_creation = IndividualCreation.find(params[:id])
    end

    def find_resourceful_controller
      @resourceful_controller = ResourcefulController.find(params[:resourceful_controller_id])
    end
end
