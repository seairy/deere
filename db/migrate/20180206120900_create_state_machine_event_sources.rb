class CreateStateMachineEventSources < ActiveRecord::Migration[5.1]
  def change
    create_table :state_machine_event_sources do |t|
      t.references :state_machine_event, null: false
      t.references :state_machine_state, null: false
      t.timestamps
    end
  end
end
