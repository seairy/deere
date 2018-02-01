class Sortable < ApplicationRecord
  belongs_to :model
  validates :scope, presence: true, length: { maximum: 25 }, format: /\A\w+\Z/, allow_blank: true
end
