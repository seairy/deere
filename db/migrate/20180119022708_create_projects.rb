class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :code, limit: 100, null: false
      t.string :name, limit: 100, null: false
      t.string :copyright, limit: 500, null: false
      t.string :primary_language, limit: 100, null: false
      t.timestamps
    end
  end
end
