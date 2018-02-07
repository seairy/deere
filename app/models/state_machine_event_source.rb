class StateMachineEventSource < ApplicationRecord
  belongs_to :state_machine_event
  belongs_to :state_machine_state
end
