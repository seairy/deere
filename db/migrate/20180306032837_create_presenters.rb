class CreatePresenters < ActiveRecord::Migration[5.1]
  def change
    create_table :presenters do |t|
      t.references :model, null: false
      t.string :code, limit: 100, null: false
      t.string :name, limit: 100, null: false
      t.string :localized_name, limit: 100, null: false
      t.timestamps
    end
  end
end
