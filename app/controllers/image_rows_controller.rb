class ImageRowsController < ApplicationController
  before_action :find_form, only: %w(new create)
  before_action :find_image_row, only: %w(destroy)

  def new
    @image_row = @form.image_rows.new
  end
  
  def edit
  end
  
  def create
    @image_row = @form.image_rows.new(image_row_params)
    if @image_row.save
      redirect_to @form.formable, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @image_row.update(model_params)
      redirect_to @image_row.form.formable, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @image_row.destroy
    redirect_to @image_row.form.formable, notice: notice_sentence
  end

  protected
    def image_row_params
      params.require(:image_row).permit!
    end

    def find_form
      @form = Form.find(params[:form_id])
    end

    def find_image_row
      @image_row = ImageRow.find(params[:id])
    end
end
