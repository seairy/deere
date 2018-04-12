class StateTransition < ApplicationRecord
  include Presentable
  extend Enumerize
  enumerize :type, in: %w(regular), predicates: { prefix: true }, scope: true
  enumerize :action_method, in: %w(patch put), predicates: { prefix: true }, scope: true
  belongs_to :resourceful_controller
  belongs_to :state_machine_event
  validates :state_machine_event, presence: true, uniqueness: { scope: :resourceful_controller }
  validates :action_code, presence: true, length: { maximum: 100 }, uniqueness: { scope: :resourceful_controller }
  validates :action_method, presence: true, inclusion: { in: StateTransition.action_method.values }
  validates :confirmable, inclusion: { in: [true, false] }
end
