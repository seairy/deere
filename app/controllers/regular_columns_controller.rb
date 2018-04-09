class RegularColumnsController < ApplicationController
  before_action :find_table, only: %w(new create)
  before_action :find_regular_column, only: %w(destroy)

  def new
    @regular_column = @table.regular_columns.new
  end
  
  def edit
  end
  
  def create
    @regular_column = @table.regular_columns.new(regular_column_params)
    if @regular_column.save
      redirect_to @table.listable, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @regular_column.update(model_params)
      redirect_to @regular_column.table.listable, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @regular_column.destroy
    redirect_to @regular_column.table.listable, notice: notice_sentence
  end

  protected
    def regular_column_params
      params.require(:regular_column).permit!
    end

    def find_table
      @table = Table.find(params[:table_id])
    end

    def find_regular_column
      @regular_column = RegularColumn.find(params[:id])
    end
end
