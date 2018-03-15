class CreateViewElements < ActiveRecord::Migration[5.1]
  def change
    create_table :view_elements do |t|
      t.string :inheritance_type, limit: 25, null: false
      t.references :view_logic, null: false
      t.boolean :include_sequence_number
      t.integer :position, limit: 2, null: false
      t.timestamps
    end
  end
end
