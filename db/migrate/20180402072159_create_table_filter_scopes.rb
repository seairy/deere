class CreateTableFilterScopes < ActiveRecord::Migration[5.1]
  def change
    create_table :table_filter_scopes do |t|
      t.references :table_filter, null: false
      t.references :property, null: false
      t.integer :position, null: false
      t.timestamps
    end
  end
end
