class StateMachineState < ApplicationRecord
  belongs_to :state_machine
  has_many :sources, class_name: 'StateMachineEventSource', dependent: :restrict_with_exception
  has_many :destinations, class_name: 'StateMachineEvent', foreign_key: 'destination_id', dependent: :restrict_with_exception
  before_create :set_initial, :set_position
  before_update :set_initial
  validates :code, presence: true, length: { maximum: 100 }, uniqueness: { scope: :state_machine }, code: true
  validates :localized_name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :state_machine }
  validates :name, presence: true, length: { maximum: 100 }, uniqueness: { scope: :state_machine }

  def self.sort sequence
    sequence.split(',').each_with_index do |id, index|
      position = index + 1
      find(id).update!(position: position)
    end
  end

  protected
    def set_initial
      if state_machine.states.count.zero?
        self.initial = true
      elsif initial?
        state_machine.states.where.not(id: id).update_all(initial: false)
      elsif initial.nil?
        self.initial = false
      end
    end

    def set_position
      self.position = state_machine.states.maximum(:position).try(:+, 1) || 1
    end
end
