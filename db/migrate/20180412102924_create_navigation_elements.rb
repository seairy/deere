class CreateNavigationElements < ActiveRecord::Migration[5.1]
  def change
    create_table :navigation_elements do |t|
      t.references :navigation, null: false
      t.references :navigable, polymorphic: true, null: false
      t.string :name, limit: 100, null: false
      t.integer :position, null: false
      t.timestamps
    end
  end
end
