class CreatePresenceValidations < ActiveRecord::Migration[5.1]
  def change
    create_table :presence_validations do |t|
      t.references :property, null: false
      t.timestamps
    end
  end
end
