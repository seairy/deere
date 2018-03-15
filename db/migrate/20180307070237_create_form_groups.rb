class CreateFormGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :form_groups do |t|
      t.string :inheritance_type, limit: 25, null: false
      t.references :form, null: false
      t.references :property, null: false
      t.string :name, limit: 100
      t.string :localized_name, limit: 100
      t.boolean :read_only
      t.boolean :searchable
      t.integer :position, limit: 2, null: false
      t.timestamps
    end
  end
end
