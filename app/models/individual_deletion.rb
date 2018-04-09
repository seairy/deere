class IndividualDeletion < ApplicationRecord
  include Presentable
  extend Enumerize
  enumerize :type, in: %w(regular), predicates: { prefix: true }, scope: true
  belongs_to :resourceful_controller
  validates :confirmable, inclusion: { in: [true, false] }
end
