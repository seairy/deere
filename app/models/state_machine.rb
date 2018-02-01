class StateMachine < ApplicationRecord
  belongs_to :model
  has_many :states, class_name: 'StateMachineState', dependent: :destroy
  has_many :events, class_name: 'StateMachineEvent', dependent: :destroy
end
