class StateMachineEvent < ApplicationRecord
  attribute :state_machine_state_ids_for_source
  belongs_to :state_machine
  belongs_to :destination, class_name: 'StateMachineState'
  has_many :sources, class_name: 'StateMachineEventSource', dependent: :destroy
  after_initialize :set_state_machine_state_ids_for_source
  before_create :set_position
  after_save :set_sources
  validates :code, presence: true, length: { maximum: 100 }, uniqueness: { scope: :state_machine }, code: true

  def self.sort sequence
    sequence.split(',').each_with_index do |id, index|
      position = index + 1
      find(id).update!(position: position)
    end
  end

  protected
    def set_state_machine_state_ids_for_source
      self.state_machine_state_ids_for_source = sources.map{|state_machine_event_source| state_machine_event_source.state_machine_state_id} unless new_record?
    end

    def set_position
      self.position = state_machine.states.maximum(:position).try(:+, 1) || 1
    end

    def set_sources
      sources.destroy_all
      state_machine_state_ids_for_source&.delete_if(&:blank?)&.each{|state_machine_state_id| sources.create!(state_machine_state_id: state_machine_state_id)}
    end
end
