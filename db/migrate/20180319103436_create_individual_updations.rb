class CreateIndividualUpdations < ActiveRecord::Migration[5.1]
  def change
    create_table :individual_updations do |t|
      t.references :resourceful_controller, null: false
      t.references :model, null: false
      t.string :type, limit: 50, null: false
      t.boolean :confirmable, null: false
      t.timestamps
    end
  end
end
