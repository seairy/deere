class CreateNavigations < ActiveRecord::Migration[5.1]
  def change
    create_table :navigations do |t|
      t.references :namespace, null: false
      t.string :name, limit: 100, null: false
      t.integer :position, null: false
      t.timestamps
    end
  end
end
