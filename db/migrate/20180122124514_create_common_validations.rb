class CreateCommonValidations < ActiveRecord::Migration[5.1]
  def change
    create_table :common_validations do |t|
      t.references :property, null: false
      t.string :empty_tolerance, limit: 25, null: false
      t.string :on_actions, limit: 25, null: false
      t.timestamps
    end
  end
end
