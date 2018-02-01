class Trashable < ApplicationRecord
  belongs_to :model
  validates :default_without_trashed, inclusion: { in: [true, false] }
end
