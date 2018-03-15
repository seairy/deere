class CreateTableColumns < ActiveRecord::Migration[5.1]
  def change
    create_table :table_columns do |t|
      t.references :table, null: false
      t.references :columnable, polymorphic: true, null: false
      t.string :name, limit: 100
      t.string :localized_name, limit: 100
      t.string :formatter, limit: 50
      t.integer :position, limit: 2, null: false
      t.timestamps
    end
  end
end
