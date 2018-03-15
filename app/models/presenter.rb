class Presenter < ApplicationRecord
  belongs_to :model
  has_many :table_columns, as: :columnable, dependent: :restrict_with_exception
  validates :code, presence: true, length: { maximum: 100 }, uniqueness: { scope: :model }, code: true
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :model }
  validates :localized_name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :model }
end
