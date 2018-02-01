class CreateUniquenessValidations < ActiveRecord::Migration[5.1]
  def change
    create_table :uniqueness_validations do |t|
      t.references :property, null: false
      t.string :scopes, limit: 1000
      t.timestamps
    end
  end
end
