class CreateIndividualUpdations < ActiveRecord::Migration[5.1]
  def change
    create_table :individual_updations do |t|
      t.references :resourceful_controller, null: false
      t.references :model, null: false
      t.string :type, limit: 50, null: false
      t.string :frontend_action_name, limit: 100
      t.string :backend_action_name, limit: 100, null: false
      t.string :backend_action_method, limit: 50, null: false
      t.boolean :confirmable, null: false
      t.timestamps
    end
  end
end
