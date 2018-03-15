class CreateStateMachineStates < ActiveRecord::Migration[5.1]
  def change
    create_table :state_machine_states do |t|
      t.references :state_machine, null: false
      t.string :code, limit: 100, null: false
      t.string :name, limit: 100, null: false
      t.string :localized_name, limit: 100, null: false
      t.boolean :initial, null: false
      t.integer :position, limit: 3, null: false
      t.timestamps
    end
  end
end
