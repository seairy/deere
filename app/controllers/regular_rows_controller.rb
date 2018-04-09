class RegularRowsController < ApplicationController
  before_action :find_form, only: %w(new create)
  before_action :find_regular_row, only: %w(destroy)

  def new
    @regular_row = @form.regular_rows.new
  end
  
  def edit
  end
  
  def create
    @regular_row = @form.regular_rows.new(regular_row_params)
    if @regular_row.save
      redirect_to @form.formable, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @regular_row.update(model_params)
      redirect_to @regular_row.form.formable, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @regular_row.destroy
    redirect_to @regular_row.form.formable, notice: notice_sentence
  end

  protected
    def regular_row_params
      params.require(:regular_row).permit!
    end

    def find_form
      @form = Form.find(params[:form_id])
    end

    def find_regular_row
      @regular_row = RegularRow.find(params[:id])
    end
end
