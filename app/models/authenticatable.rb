class Authenticatable < ApplicationRecord
  belongs_to :model
  validates :account_field_name, presence: true, length: { maximum: 25 }, format: /\A\w+\Z/
end
