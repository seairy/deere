class NumericalityValidation < ApplicationRecord
  include Iconize
  belongs_to :property
  validates :minimum, numericality: true, allow_blank: true
  validates :includes_minimum, inclusion: { in: [true, false] }, allow_blank: true
  validates :maximum, numericality: true, allow_blank: true
  validates :includes_maximum, inclusion: { in: [true, false] }, allow_blank: true
  validates :only_integer, inclusion: { in: [true, false] }
  validate :minimum_must_be_provided_before_include
  validate :maximum_must_be_provided_before_include

  def summary
    [].tap do |result|
      result << ">#{"=" if includes_minimum} #{minimum}" if minimum.present?
      result << "<#{"=" if includes_maximum} #{maximum}" if maximum.present?
      result << "only integer" if only_integer?
    end.join(', ')
  end

  protected
    def minimum_must_be_provided_before_include
      errors.add(:base, :minimum_must_be_provided_before_include) if self.minimum.blank? and self.includes_minimum
    end

    def maximum_must_be_provided_before_include
      errors.add(:base, :maximum_must_be_provided_before_include) if self.maximum.blank? and self.includes_maximum
    end
end
