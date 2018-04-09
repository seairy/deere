# -*- encoding : utf-8 -*-
class TableFilterScopesController < ApplicationController
  before_action :find_table_filter, only: %w(new create)
  before_action :find_table_filter_scope, only: %w(edit update destroy)
  
  def new
    @table_filter_scope = @table_filter.scopes.new
  end
  
  def edit
  end
  
  def create
    @table_filter_scope = @table_filter.scopes.new(table_filter_scope_params)
    if @table_filter_scope.save
      redirect_to @table_filter.table.listable, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @table_filter_scope.update(table_filter_scope_params)
      redirect_to @table_filter_scope.table_filter.table.listable, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @table_filter_scope.destroy!
    redirect_to @table_filter_scope.table_filter.table.listable, notice: notice_sentence
  end

  protected
    def table_filter_scope_params
      params.require(:table_filter_scope).permit!
    end

    def find_table_filter
      @table_filter = TableFilter.find(params[:table_filter_id])
    end

    def find_table_filter_scope
      @table_filter_scope = TableFilterScope.find(params[:id])
    end
end
