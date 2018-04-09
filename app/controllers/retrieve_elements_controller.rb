class RetrieveElementsController < ApplicationController
  before_action :find_retrieve_element, only: %w(show edit update destroy)
  before_action :find_resourceful_controller, only: %w(new create)

  def show
    @activated_tables = @retrieve_element.tables
    @unactivated_models_as_form = @retrieve_element.model.cascades_as_source.where(type: :has_one).map(&:destination).reject{ |model| @retrieve_element.tables.map(&:model_id).include?(model.id) }
    @unactivated_models_as_table = @retrieve_element.model.cascades_as_source.where(type: :has_many).map(&:destination).reject{ |model| @retrieve_element.tables.map(&:model_id).include?(model.id) }
  end

  def new
    @retrieve_element = @resourceful_controller.build_retrieve_element
  end

  def edit
  end

  def create
    @retrieve_element = @resourceful_controller.build_retrieve_element(retrieve_element_params)
    if @retrieve_element.save
      redirect_to @retrieve_element, notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @retrieve_element.update(retrieve_element_params)
      redirect_to @retrieve_element, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @retrieve_element.destroy
    redirect_to @retrieve_element.resourceful_controller, notice: notice_sentence
  end

  protected
    def retrieve_element_params
      params.require(:retrieve_element).permit!
    end

    def find_retrieve_element
      @retrieve_element = RetrieveElement.find(params[:id])
    end

    def find_resourceful_controller
      @resourceful_controller = ResourcefulController.find(params[:resourceful_controller_id])
    end
end
