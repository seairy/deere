class ExclusionValidation < ApplicationRecord
  include Iconize
  serialize :values, Array
  belongs_to :property
end
