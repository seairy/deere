class CreateViewLogics < ActiveRecord::Migration[5.1]
  def change
    create_table :view_logics do |t|
      t.string :inheritance_type, limit: 25, null: false
      t.references :namespace, null: false
      t.references :model, null: false
      t.string :type, limit: 25, null: false
      t.timestamps
    end
  end
end
