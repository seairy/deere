class EnumerationElementsController < ApplicationController
  before_action :find_enumeration_element, only: %w(edit update destroy)
  before_action :find_enumeration_property, only: %w(new create)

  def new
    @enumeration_element = @enumeration_property.elements.new
  end

  def edit
  end

  def create
    @enumeration_element = @enumeration_property.elements.new(enumeration_element_params)
    if @enumeration_element.save
      redirect_to edit_enumeration_property_path(@enumeration_element.enumeration_property), notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @enumeration_element.update(enumeration_element_params)
      redirect_to edit_enumeration_property_path(@enumeration_element.enumeration_property), notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @enumeration_element.destroy
    redirect_to edit_enumeration_property_path(@enumeration_element.enumeration_property), notice: notice_sentence
  end

  def sort
    EnumerationElement.sort(params[:enumeration_element_ids])
    head 200
  end

  protected
    def enumeration_element_params
      params.require(:enumeration_element).permit!
    end

    def find_enumeration_element
      @enumeration_element = EnumerationElement.find(params[:id])
    end

    def find_enumeration_property
      @enumeration_property = EnumerationProperty.find(params[:enumeration_property_id])
    end
end
