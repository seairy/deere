class CreateNumericalityValidations < ActiveRecord::Migration[5.1]
  def change
    create_table :numericality_validations do |t|
      t.references :property, null: false
      t.decimal :minimum, precision: 64, scale: 30
      t.boolean :includes_minimum
      t.integer :maximum, precision: 64, scale: 30
      t.boolean :includes_maximum
      t.boolean :only_integer, null: false
      t.timestamps
    end
  end
end
