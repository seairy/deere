class TableFilterScope < ApplicationRecord
  belongs_to :table_filter
  belongs_to :property
  before_create :set_position
  scope :sorted, -> { order(:position) }
  validates :property, uniqueness: { scope: :table_filter }

  protected
    def set_position
      self.position = table_filter.scopes.maximum(:position).try(:+, 1) || 1
    end
end
