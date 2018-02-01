class CreateAcceptanceValidations < ActiveRecord::Migration[5.1]
  def change
    create_table :acceptance_validations do |t|
      t.references :property, null: false
      t.string :accept, limit: 25
      t.timestamps
    end
  end
end
