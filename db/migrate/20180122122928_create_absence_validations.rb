class CreateAbsenceValidations < ActiveRecord::Migration[5.1]
  def change
    create_table :absence_validations do |t|
      t.references :property, null: false
      t.timestamps
    end
  end
end
