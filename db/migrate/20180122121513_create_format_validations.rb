class CreateFormatValidations < ActiveRecord::Migration[5.1]
  def change
    create_table :format_validations do |t|
      t.references :property, null: false
      t.string :regular_expression, limit: 500, null: false
      t.timestamps
    end
  end
end
