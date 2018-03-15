# -*- encoding : utf-8 -*-
class FormGroupsController < ApplicationController
  before_action :find_form, only: %w(new create)
  before_action :find_form_group, only: %w(edit update destroy)
  
  def new
    @form_group = @form.groups.new
  end
  
  def edit
  end
  
  def create
    @form_group = @form.groups.new(form_group_params)
    if @form_group.save
      redirect_to @form, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @form_group.update(form_group_params)
      redirect_to @form_group.form, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @form_group.destroy!
    redirect_to @form_group.form, notice: notice_sentence
  end

  protected
    def form_group_params
      params.require(:form_group).permit!
    end

    def find_form
      @form = Form.find(params[:form_id])
    end

    def find_form_group
      @form_group = FormGroup.find(params[:id])
    end
end
