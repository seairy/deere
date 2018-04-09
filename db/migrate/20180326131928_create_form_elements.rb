class CreateFormElements < ActiveRecord::Migration[5.1]
  def change
    create_table :form_elements do |t|
      t.string :inheritance_type, limit: 50, null: false
      t.references :form, null: false
      t.references :property, null: false
      t.boolean :required
      t.string :plugin, limit: 100
      t.integer :position, null: false
      t.timestamps
    end
  end
end
