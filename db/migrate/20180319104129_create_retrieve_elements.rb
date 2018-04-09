class CreateRetrieveElements < ActiveRecord::Migration[5.1]
  def change
    create_table :retrieve_elements do |t|
      t.references :resourceful_controller, null: false
      t.references :model, null: false
      t.string :type, limit: 50, null: false
      t.timestamps
    end
  end
end
