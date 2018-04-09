class CreateTableFilters < ActiveRecord::Migration[5.1]
  def change
    create_table :table_filters do |t|
      t.references :table, null: false
      t.timestamps
    end
  end
end
