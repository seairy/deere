class CreateSortables < ActiveRecord::Migration[5.1]
  def change
    create_table :sortables do |t|
      t.references :model, null: false
      t.string :scope, limit: 25
      t.timestamps
    end
  end
end
