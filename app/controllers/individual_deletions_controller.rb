class IndividualDeletionsController < ApplicationController
  before_action :find_individual_deletion, only: %w(show edit update destroy)
  before_action :find_resourceful_controller, only: %w(new create)

  def show
  end

  def new
    @individual_deletion = @resourceful_controller.build_individual_deletion(confirmable: false)
  end

  def edit
  end

  def create
    @individual_deletion = @resourceful_controller.build_individual_deletion(individual_deletion_params)
    if @individual_deletion.save
      redirect_to @individual_deletion, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @individual_deletion.update(individual_deletion_params)
      redirect_to @individual_deletion, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @individual_deletion.destroy
    redirect_to @individual_deletion.resourceful_controller, notice: notice_sentence
  end

  protected
    def individual_deletion_params
      params.require(:individual_deletion).permit!
    end

    def find_individual_deletion
      @individual_deletion = IndividualDeletion.find(params[:id])
    end

    def find_resourceful_controller
      @resourceful_controller = ResourcefulController.find(params[:resourceful_controller_id])
    end
end
