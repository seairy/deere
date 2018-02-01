class FormatValidation < ApplicationRecord
  include Iconize
  belongs_to :property
  validates :regular_expression, presence: true, length: { maximum: 500 }
end
