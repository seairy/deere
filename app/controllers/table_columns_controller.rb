# -*- encoding : utf-8 -*-
class TableColumnsController < ApplicationController
  before_action :find_table, only: %w(new create)
  before_action :find_table_column, only: %w(edit update destroy)
  
  def new
    @table_column = @table.columns.new
  end
  
  def edit
  end
  
  def create
    @table_column = @table.columns.new(table_column_params)
    @table_column.columnable_type = case params[:type]
                                    when 'property' then Property
                                    when 'presenter' then Presenter
                                    end
    if @table_column.save
      redirect_to @table, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @table_column.update(table_column_params)
      redirect_to @table_column.table, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @table_column.destroy!
    redirect_to @table_column.table, notice: notice_sentence
  end

  protected
    def table_column_params
      params.require(:table_column).permit!
    end

    def find_table
      @table = Table.find(params[:table_id])
    end

    def find_table_column
      @table_column = TableColumn.find(params[:id])
    end
end
