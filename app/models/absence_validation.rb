class AbsenceValidation < ApplicationRecord
  include Iconize
  belongs_to :property
end
