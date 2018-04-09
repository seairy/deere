class CreateForms < ActiveRecord::Migration[5.1]
  def change
    create_table :forms do |t|
      t.references :formable, polymorphic: true, null: false
      t.references :model, null: false
      t.timestamps
    end
  end
end
