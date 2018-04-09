class IndividualUpdation < ApplicationRecord
  include Presentable
  extend Enumerize
  enumerize :type, in: %w(regular), predicates: { prefix: true }, scope: true
  enumerize :backend_action_method, in: %w(patch put), predicates: { prefix: true }, scope: true
  belongs_to :resourceful_controller
  validates :frontend_action_name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :resourceful_controller }
  validates :backend_action_name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :resourceful_controller }
  validates :backend_action_method, presence: true, inclusion: { in: IndividualUpdation.backend_action_method.values }
  validates :confirmable, inclusion: { in: [true, false] }
end
