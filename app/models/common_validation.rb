class CommonValidation < ApplicationRecord
  extend Enumerize
  belongs_to :property
  enumerize :empty_tolerance, in: %w(none null blank), predicates: { prefix: true }, scope: true
  enumerize :on_actions, in: %w(all create update), predicates: { prefix: true }, scope: true
  validates :empty_tolerance, presence: true
  validates :on_actions, presence: true
end
