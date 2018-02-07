class Project < ApplicationRecord
  has_many :models
  validates :name, presence: true, length: { maximum: 100 }, format: /\A\w+\Z/
end
