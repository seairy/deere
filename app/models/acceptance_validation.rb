class AcceptanceValidation < ApplicationRecord
  include Iconize
  belongs_to :property

  def summary
    "accept: #{accept}" if accept.present?
  end
end
