class CreateEnumerationElements < ActiveRecord::Migration[5.1]
  def change
    create_table :enumeration_elements do |t|
      t.references :enumeration_property
      t.string :name, limit: 50, null: false
      t.string :zh_name, limit: 50, null: false
      t.string :en_name, limit: 50, null: false
      t.integer :position, limit: 2, null: false
      t.timestamps
    end
  end
end
