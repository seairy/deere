class CreateCascades < ActiveRecord::Migration[5.1]
  def change
    create_table :cascades do |t|
      t.references :source, null: false
      t.references :destination, null: false
      t.string :type, limit: 50, null: false
      t.boolean :optional, null: false
      t.string :source_alias_name, limit: 100
      t.string :destination_alias_name, limit: 100
      t.timestamps
    end
  end
end
