class PresenceValidation < ApplicationRecord
  include Iconize
  belongs_to :property
end
