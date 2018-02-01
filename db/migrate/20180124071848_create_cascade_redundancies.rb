class CreateCascadeRedundancies < ActiveRecord::Migration[5.1]
  def change
    create_table :cascade_redundancies do |t|
      t.references :cascade, null: false
      t.references :model, null: false
      t.timestamps
    end
  end
end
