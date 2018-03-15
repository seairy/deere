class CustomValidation < ApplicationRecord
  belongs_to :model
  validates :code, presence: true, length: { maximum: 100 }, uniqueness: { scope: :model }, code: true
end
