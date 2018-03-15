class TablePagination < ApplicationRecord
  belongs_to :table
  validates :per_page, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 200 }
end
