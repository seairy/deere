class InclusionValidation < ApplicationRecord
  include Iconize
  serialize :values, Array
  belongs_to :property
  validates :values, presence: true
end
