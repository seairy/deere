class CreateStateMachineEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :state_machine_events do |t|
      t.references :state_machine, null: false
      t.references :destination, null: false
      t.string :code, limit: 100, null: false
      t.integer :position, limit: 3, null: false
      t.timestamps
    end
  end
end
