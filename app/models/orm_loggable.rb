class OrmLoggable < ApplicationRecord
  belongs_to :model
  validates :on_create, inclusion: { in: [true, false] }
  validates :on_update, inclusion: { in: [true, false] }
  validates :on_destroy, inclusion: { in: [true, false] }
  validates :comment_required, inclusion: { in: [true, false] }
end
