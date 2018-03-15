class CreateTemplateElements < ActiveRecord::Migration[5.1]
  def change
    create_table :template_elements do |t|
      t.string :inheritance_type, limit: 25, null: false
      t.references :template, null: false
      t.boolean :include_sequence_number
      t.integer :position, null: false
      t.timestamps
    end
  end
end
