class LengthValidation < ApplicationRecord
  include Iconize
  belongs_to :property
  validate :at_least_one_of_minimum_or_maximum

  protected
    def at_least_one_of_minimum_or_maximum
      errors.add(:base, :at_least_one_of_minimum_or_maximum) if self.minimum.blank? and self.maximum.blank?
    end
end
