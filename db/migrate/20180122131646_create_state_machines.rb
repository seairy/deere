class CreateStateMachines < ActiveRecord::Migration[5.1]
  def change
    create_table :state_machines do |t|
      t.references :model, null: false
      t.timestamps
    end
  end
end
