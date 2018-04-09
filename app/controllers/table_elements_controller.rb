class TableElementsController < ApplicationController
  before_action :find_table, only: %w(sort)

  def sort
    case request.method
    when "GET"
      @table_elements = @table.elements.order(:position)
    when "PUT"
      TableElement.sort(params[:table_element_ids])
      head 200
    end
  end

  protected
    def find_table
      @table = Table.find(params[:table_id])
    end
end
