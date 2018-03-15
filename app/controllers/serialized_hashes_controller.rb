class SerializedHashesController < ApplicationController
  before_action :find_serialized_hash, only: %w(edit update destroy)
  before_action :find_hash_property, only: %w(new create)

  def new
    @serialized_hash = @hash_property.serialized_hashes.new
  end

  def edit
  end

  def create
    @serialized_hash = @hash_property.serialized_hashes.new(serialized_hash_params)
    if @serialized_hash.save
      redirect_to edit_hash_property_path(@serialized_hash.hash_property), notice: notice_sentence
    else
      render action: 'new'
    end
  end

  def update
    if @serialized_hash.update(serialized_hash_params)
      redirect_to edit_hash_property_path(@serialized_hash.hash_property), notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @serialized_hash.destroy
    redirect_to edit_hash_property_path(@serialized_hash.hash_property), notice: notice_sentence
  end

  protected
    def serialized_hash_params
      params.require(:serialized_hash).permit!
    end

    def find_serialized_hash
      @serialized_hash = SerializedHash.find(params[:id])
    end

    def find_hash_property
      @hash_property = HashProperty.find(params[:hash_property_id])
    end
end
