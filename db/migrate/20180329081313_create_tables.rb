class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :tables do |t|
      t.references :listable, polymorphic: true, null: false
      t.references :model, null: false
      t.timestamps
    end
  end
end
