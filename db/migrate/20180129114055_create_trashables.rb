class CreateTrashables < ActiveRecord::Migration[5.1]
  def change
    create_table :trashables do |t|
      t.references :model, null: false
      t.boolean :default_without_trashed, null: false
      t.timestamps
    end
  end
end
