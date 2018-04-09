class PopoverColumnsController < ApplicationController
  before_action :find_table, only: %w(new create)
  before_action :find_popover_column, only: %w(destroy)

  def new
    @popover_column = @table.popover_columns.new
  end
  
  def edit
  end
  
  def create
    @popover_column = @table.popover_columns.new(popover_column_params)
    if @popover_column.save
      redirect_to @table.listable, notice: notice_sentence
    else
      render action: 'new'
    end
  end
  
  def update
    if @popover_column.update(model_params)
      redirect_to @popover_column.table.listable, notice: notice_sentence
    else
      render action: 'edit'
    end
  end

  def destroy
    @popover_column.destroy
    redirect_to @popover_column.table.listable, notice: notice_sentence
  end

  protected
    def popover_column_params
      params.require(:popover_column).permit!
    end

    def find_table
      @table = Table.find(params[:table_id])
    end

    def find_popover_column
      @popover_column = PopoverColumn.find(params[:id])
    end
end
