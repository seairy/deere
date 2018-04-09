# -*- encoding : utf-8 -*-
class FormsController < ApplicationController
  before_action :find_form, only: %w(demonstration destroy)

  def destroy
    @form.destroy!
    redirect_to @form.formable, notice: notice_sentence
  end

  def demonstration
    @form_elements = @form.elements.order(:position)
  end

  protected
    def form_params
      params.require(:form).permit!
    end

    def find_form
      @form = Form.find(params[:id])
    end
end
