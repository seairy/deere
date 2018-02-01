class CreateStateMachineStates < ActiveRecord::Migration[5.1]
  def change
    create_table :state_machine_states do |t|
      t.references :state_machine, null: false
      t.string :name, limit: 200, null: false
      t.timestamps
    end
  end
end
