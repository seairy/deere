class ImageUploadersController < ApplicationController
  before_action :find_image_uploader, only: %w(edit update destroy)
  before_action :find_file_property, only: %w(new create)

  def new
    @image_uploader = @file_property.image_uploaders.new
  end

  def edit
  end

  def create
    @image_uploader = @file_property.image_uploaders.new(image_uploader_params)
    if @image_uploader.save
      redirect_to edit_file_property_path(@image_uploader.file_property), notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @image_uploader.update(image_uploader_params)
      redirect_to edit_file_property_path(@image_uploader.file_property), notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @image_uploader.destroy
    redirect_to edit_file_property_path(@image_uploader.file_property), notice: notice_sentence
  end

  protected
    def image_uploader_params
      params.require(:image_uploader).permit!
    end

    def find_image_uploader
      @image_uploader = ImageUploader.find(params[:id])
    end

    def find_file_property
      @file_property = FileProperty.find(params[:file_property_id])
    end
end
