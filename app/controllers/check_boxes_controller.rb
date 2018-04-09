# -*- encoding : utf-8 -*-
class CheckBoxesController < ApplicationController
  before_action :find_form, only: %w(new create)
  before_action :find_check_box, only: %w(edit update destroy)
  
  def new
    @check_box = @form.check_boxes.new
  end
  
  def edit
  end
  
  def create
    @check_box = @form.check_boxes.new(check_box_params)
    if @check_box.save
      redirect_to @form.formable, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @check_box.update(check_box_params)
      redirect_to @check_box.form.formable, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @check_box.destroy!
    redirect_to @check_box.form.formable, notice: notice_sentence
  end

  protected
    def check_box_params
      params.require(:check_box).permit!
    end

    def find_form
      @form = Form.find(params[:form_id])
    end

    def find_check_box
      @check_box = CheckBox.find(params[:id])
    end
end
