class CreateNamespaces < ActiveRecord::Migration[5.1]
  def change
    create_table :namespaces do |t|
      t.references :project, null: false
      t.string :name, limit: 100, null: false
      t.string :module, limit: 100, null: false
      t.string :path, limit: 100, null: false
      t.timestamps
    end
  end
end
