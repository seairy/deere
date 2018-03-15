# -*- encoding : utf-8 -*-
class TablesController < ApplicationController
  before_action :find_view_logic, only: %w(new create)
  before_action :find_table, only: %w(show edit update destroy)
  
  def show
  end
  
  def new
    @table = @view_logic.tables.new
  end
  
  def edit
  end
  
  def create
    @table = @view_logic.tables.new(table_params)
    if @table.save
      redirect_to @table, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @table.update(table_params)
      redirect_to @table, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @table.destroy!
    redirect_to @table.view_logic, notice: notice_sentence
  end

  protected
    def table_params
      params.require(:table).permit!
    end

    def find_view_logic
      @view_logic = ViewLogic.find(params[:view_logic_id])
    end

    def find_table
      @table = Table.find(params[:id])
    end
end
