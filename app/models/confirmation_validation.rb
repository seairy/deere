class ConfirmationValidation < ApplicationRecord
  include Iconize
  belongs_to :property

  def summary
    "case_sensitive: #{case_sensitive}"
  end
end
