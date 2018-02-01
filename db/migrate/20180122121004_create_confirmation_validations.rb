class CreateConfirmationValidations < ActiveRecord::Migration[5.1]
  def change
    create_table :confirmation_validations do |t|
      t.references :property, null: false
      t.boolean :case_sensitive, null: false
      t.timestamps
    end
  end
end
