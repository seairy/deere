# -*- encoding : utf-8 -*-
class TablePaginationsController < ApplicationController
  before_action :find_table, only: %w(new create)
  before_action :find_table_pagination, only: %w(edit update destroy)
  
  def new
    @table_pagination = @table.build_pagination(per_page: ApplicationConstant::DefaultTablePerPage)
  end
  
  def edit
  end
  
  def create
    @table_pagination = @table.build_pagination(table_pagination_params)
    if @table_pagination.save
      redirect_to @table.listable, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @table_pagination.update(table_pagination_params)
      redirect_to @table_pagination.table.listable, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @table_pagination.destroy!
    redirect_to @table_pagination.table.listable, notice: notice_sentence
  end

  protected
    def table_pagination_params
      params.require(:table_pagination).permit!
    end

    def find_table
      @table = Table.find(params[:table_id])
    end

    def find_table_pagination
      @table_pagination = TablePagination.find(params[:id])
    end
end
