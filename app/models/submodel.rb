class Submodel < ApplicationRecord
  belongs_to :model
  validates :code, presence: true, length: { maximum: 100 }, uniqueness: { scope: :model }, code: true
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :model }
  validates :localized_name, presence: true, length: { maximum: 50 }, uniqueness: { scope: :model }
end
