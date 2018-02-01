class CreateAuthenticatables < ActiveRecord::Migration[5.1]
  def change
    create_table :authenticatables do |t|
      t.references :model, null: false
      t.string :account_field_name, limit: 25, null: false
      t.timestamps
    end
  end
end
