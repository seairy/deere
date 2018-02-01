class CreateInclusionValidations < ActiveRecord::Migration[5.1]
  def change
    create_table :inclusion_validations do |t|
      t.references :property, null: false
      t.string :values, limit: 1000, null: false
      t.timestamps
    end
  end
end
