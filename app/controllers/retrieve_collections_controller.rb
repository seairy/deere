class RetrieveCollectionsController < ApplicationController
  before_action :find_retrieve_collection, only: %w(show edit update destroy)
  before_action :find_resourceful_controller, only: %w(new create)

  def show
  end

  def new
    @retrieve_collection = @resourceful_controller.retrieve_collections.new(action_name: "index")
  end

  def edit
  end

  def create
    @retrieve_collection = @resourceful_controller.retrieve_collections.new(retrieve_collection_params)
    if @retrieve_collection.save
      redirect_to @retrieve_collection, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @retrieve_collection.update(retrieve_collection_params)
      redirect_to @retrieve_collection, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @retrieve_collection.destroy
    redirect_to @retrieve_collection.resourceful_controller, notice: notice_sentence
  end

  protected
    def retrieve_collection_params
      params.require(:retrieve_collection).permit!
    end

    def find_retrieve_collection
      @retrieve_collection = RetrieveCollection.find(params[:id])
    end

    def find_resourceful_controller
      @resourceful_controller = ResourcefulController.find(params[:resourceful_controller_id])
    end
end
