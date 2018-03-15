# -*- encoding : utf-8 -*-
class TextFieldsController < ApplicationController
  before_action :find_form, only: %w(new create)
  before_action :find_text_field, only: %w(edit update destroy)
  
  def new
    @text_field = @form.text_fields.new
  end
  
  def edit
  end
  
  def create
    @text_field = @form.text_fields.new(text_field_params)
    if @text_field.save
      redirect_to @form, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @text_field.update(text_field_params)
      redirect_to @text_field.form, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @text_field.destroy!
    redirect_to @text_field.form, notice: notice_sentence
  end

  protected
    def text_field_params
      params.require(:text_field).permit!
    end

    def find_form
      @form = Form.find(params[:form_id])
    end

    def find_text_field
      @text_field = TextField.find(params[:id])
    end
end
