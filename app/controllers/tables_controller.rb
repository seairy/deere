# -*- encoding : utf-8 -*-
class TablesController < ApplicationController
  before_action :find_listable_and_model, only: %w(create)
  before_action :find_table, only: %w(demonstration destroy)

  def create
    @table = @listable.tables.new(listable: @listable, model: @model)
    if @table.save
      redirect_to @listable, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def destroy
    @table.destroy!
    redirect_to @table.listable, notice: notice_sentence
  end

  def demonstration
  end

  protected
    def find_listable_and_model
      @listable = if params[:retrieve_element_id].present?
        RetrieveElement.find(params[:retrieve_element_id])
      end
      @model = Model.find(params[:model_id])
    end

    def find_table
      @table = Table.find(params[:id])
    end
end
