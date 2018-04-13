# -*- encoding : utf-8 -*-
class NavigationElementsController < ApplicationController
  before_action :find_navigation_element, only: %w(edit update destroy)
  before_action :find_navigation, only: %w(new create)
  
  def new
    @navigation_element = @navigation.elements.new
    @view_logic_options = view_logic_options
  end
  
  def edit
  end
  
  def create
    @navigation_element = @navigation.elements.new(navigation_element_params.merge(navigable_type: params[:type]))
    if @navigation_element.save
      redirect_to @navigation, notice: notice_sentence
    else
      @view_logic_options = view_logic_options
      render action: 'new'
    end
  end
  
  def update
    if @navigation_element.update(navigation_element_params)
      redirect_to @navigation_element.navigation, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @navigation_element.destroy!
    redirect_to @navigation_element.navigation, notice: notice_sentence
  end

  protected
    def navigation_element_params
      params.require(:navigation_element).permit!
    end

    def find_navigation_element
      @navigation_element = NavigationElement.find(params[:id])
    end

    def find_navigation
      @navigation = Navigation.find(params[:navigation_id])
    end

    def view_logic_options
      @navigation.elements.where(navigable_type: params[:type]).map(&:navigable_id).tap do |exist_navigable_id|
        return case params[:type]
               when "RetrieveCollection"
                 @navigation.namespace.retrieve_collections.where.not(id: exist_navigable_id).map { |retrieve_collection| ["#{retrieve_collection.model.name}##{retrieve_collection.action_code}", retrieve_collection.id]}
               when "IndividualCreation"
                 @navigation.namespace.individual_creations.where.not(id: exist_navigable_id).map { |individual_creation| ["#{individual_creation.model.name}#new", individual_creation.id]}
               end
      end
    end
end
