class CreateTableElements < ActiveRecord::Migration[5.1]
  def change
    create_table :table_elements do |t|
      t.string :inheritance_type, limit: 50, null: false
      t.references :table, null: false
      t.references :property, null: false
      t.integer :position, null: false
      t.timestamps
    end
  end
end
