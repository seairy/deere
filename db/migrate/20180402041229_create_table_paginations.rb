class CreateTablePaginations < ActiveRecord::Migration[5.1]
  def change
    create_table :table_paginations do |t|
      t.references :table, null: false
      t.integer :per_page, null: false
      t.timestamps
    end
  end
end
