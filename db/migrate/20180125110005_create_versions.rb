class CreateVersions < ActiveRecord::Migration[5.1]
  def change
    create_table :versions do |t|
      t.references :project, null: false
      t.integer :major, limit: 2, null: false
      t.integer :minor, limit: 2, null: false
      t.integer :patch, limit: 2, null: false
      t.text :description, null: false
      t.timestamps
    end
  end
end
