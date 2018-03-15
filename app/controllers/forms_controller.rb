# -*- encoding : utf-8 -*-
class FormsController < ApplicationController
  before_action :find_view_logic, only: %w(new create)
  before_action :find_form, only: %w(show edit update destroy)
  
  def show
  end
  
  def new
    @form = @view_logic.forms.new
  end
  
  def edit
  end
  
  def create
    @form = @view_logic.forms.new#(form_params)
    if @form.save
      redirect_to @form, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @form.update(form_params)
      redirect_to @form, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @form.destroy!
    redirect_to @form.view_logic, notice: notice_sentence
  end

  protected
    def form_params
      params.require(:form).permit!
    end

    def find_view_logic
      @view_logic = ViewLogic.find(params[:view_logic_id])
    end

    def find_form
      @form = Form.find(params[:id])
    end
end
