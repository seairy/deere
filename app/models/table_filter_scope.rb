class TableFilterScope < ApplicationRecord
  belongs_to :table_filter
  belongs_to :property
  before_create :set_position
  scope :sorted, -> { order(:position) }
  validates :property, uniqueness: { scope: :table_filter }

  def style
    case property.model_id
    when table_filter.table.listable.model_id
      case property
      when RegularProperty
        case property.type
        when "string", "text" then :text_search
        when "integer", "float", "decimal" then :text_range
        when "datetime" then :datetime_range
        when "date" then :date_range
        when "time" then :time_range
        when "boolean" then :select
        end
      when EnumerationProperty then :select
      end
    else :select
    end
  end

  protected
    def set_position
      self.position = table_filter.scopes.maximum(:position).try(:+, 1) || 1
    end
end
