class CreateIndividualCreations < ActiveRecord::Migration[5.1]
  def change
    create_table :individual_creations do |t|
      t.references :resourceful_controller, null: false
      t.references :model, null: false
      t.string :type, limit: 50, null: false
      t.references :nested_model_as_parent
      t.boolean :confirmable, null: false
      t.timestamps
    end
  end
end
