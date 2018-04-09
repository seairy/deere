class CreateRetrieveCollections < ActiveRecord::Migration[5.1]
  def change
    create_table :retrieve_collections do |t|
      t.references :resourceful_controller, null: false
      t.references :model, null: false
      t.string :type, limit: 50, null: false
      t.string :action_name, limit: 100, null: false
      t.timestamps
    end
  end
end
