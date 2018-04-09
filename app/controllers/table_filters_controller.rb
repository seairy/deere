# -*- encoding : utf-8 -*-
class TableFiltersController < ApplicationController
  before_action :find_table, only: %w(create)
  before_action :find_table_filter, only: %w(edit update destroy)
  
  def edit
  end
  
  def create
    @table_filter = @table.build_filter
    if @table_filter.save
      redirect_to @table.listable, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @table_filter.update(table_filter_params)
      redirect_to @table_filter.table.listable, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @table_filter.destroy!
    redirect_to @table_filter.table.listable, notice: notice_sentence
  end

  protected
    def find_table
      @table = Table.find(params[:table_id])
    end

    def find_table_filter
      @table_filter = TableFilter.find(params[:id])
    end
end
