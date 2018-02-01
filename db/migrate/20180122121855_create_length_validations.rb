class CreateLengthValidations < ActiveRecord::Migration[5.1]
  def change
    create_table :length_validations do |t|
      t.references :property, null: false
      t.integer :minimum
      t.integer :maximum
      t.timestamps
    end
  end
end
