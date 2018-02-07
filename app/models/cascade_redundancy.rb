class CascadeRedundancy < ApplicationRecord
  belongs_to :cascade
  belongs_to :model
  validates :model, uniqueness: { scope: :cascade }
end
