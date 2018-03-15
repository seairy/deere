class TableColumn < ApplicationRecord
  include FormatterEnumerations
  belongs_to :table
  belongs_to :columnable, polymorphic: true
  before_create :set_position
  validates :columnable_id, uniqueness: { scope: %i(columnable_type table) }

  protected
    def set_position
      self.position = table.columns.maximum(:position).try(:+, 1) || 1
    end
end
