class CreateCustomValidations < ActiveRecord::Migration[5.1]
  def change
    create_table :custom_validations do |t|
      t.references :model, null: false
      t.string :code, limit: 100, null: false
      t.timestamps
    end
  end
end
