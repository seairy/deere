class CreateEnumerationElements < ActiveRecord::Migration[5.1]
  def change
    create_table :enumeration_elements do |t|
      t.references :enumeration_property
      t.string :code, limit: 100, null: false
      t.string :name, limit: 100, null: false
      t.string :localized_name, limit: 100, null: false
      t.integer :position, limit: 3, null: false
      t.timestamps
    end
  end
end
