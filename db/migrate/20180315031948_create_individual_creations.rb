class CreateIndividualCreations < ActiveRecord::Migration[5.1]
  def change
    create_table :individual_creations do |t|
      t.references :resourceful_controller, null: false
      t.timestamps
    end
  end
end
