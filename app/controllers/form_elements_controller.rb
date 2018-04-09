class FormElementsController < ApplicationController
  before_action :find_form, only: %w(sort)

  def sort
    case request.method
    when "GET"
      @form_elements = @form.elements.order(:position)
    when "PUT"
      FormElement.sort(params[:form_element_ids])
      head 200
    end
  end

  protected
    def find_form
      @form = Form.find(params[:form_id])
    end
end
