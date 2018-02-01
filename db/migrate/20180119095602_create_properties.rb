class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :inheritance_type, limit: 25, null: false
      t.references :model, null: false
      t.string :name, limit: 100, null: false
      t.string :zh_name, limit: 100, null: false
      t.string :en_name, limit: 100, null: false
      t.string :type, limit: 50, null: false
      t.integer :precision, limit: 1
      t.integer :scale, limit: 1
      t.integer :position, limit: 3, null: false
      t.timestamps
    end
  end
end
