class IndividualCreation < ApplicationRecord
  include Presentable
  extend Enumerize
  enumerize :type, in: %w(regular), predicates: { prefix: true }, scope: true
  belongs_to :resourceful_controller
  belongs_to :nested_model_as_parent, class_name: "Cascade", optional: true
  has_many :navigation_elements, as: :navigable
  validates :confirmable, inclusion: { in: [true, false] }
end
