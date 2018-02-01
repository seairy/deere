class CascadeRedundancy < ApplicationRecord
  belongs_to :cascade
  belongs_to :model
end
