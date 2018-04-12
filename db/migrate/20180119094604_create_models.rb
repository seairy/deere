class CreateModels < ActiveRecord::Migration[5.1]
  def change
    create_table :models do |t|
      t.references :project, null: false
      t.string :code, limit: 100, null: false
      t.string :name, limit: 100, null: false
      t.string :includes_classes, limit: 1000
      t.string :extends_classes, limit: 1000
      t.timestamps
    end
  end
end
