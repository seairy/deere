class CreateStateTransitions < ActiveRecord::Migration[5.1]
  def change
    create_table :state_transitions do |t|
      t.references :resourceful_controller, null: false
      t.references :model, null: false
      t.string :type, limit: 50, null: false
      t.string :action_name, limit: 100, null: false
      t.string :action_method, limit: 50, null: false
      t.boolean :confirmable, null: false
      t.timestamps
    end
  end
end
