class CreateResourcefulControllers < ActiveRecord::Migration[5.1]
  def change
    create_table :resourceful_controllers do |t|
      t.references :namespace, null: false
      t.references :model, null: false
      t.timestamps
    end
  end
end
