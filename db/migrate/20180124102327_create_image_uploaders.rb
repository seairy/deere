class CreateImageUploaders < ActiveRecord::Migration[5.1]
  def change
    create_table :image_uploaders do |t|
      t.references :file_property, null: false
      t.integer :quality, limit: 1, null: false
      t.string :resize_method, limit: 4, null: false
      t.integer :width, limit: 2, null: false
      t.integer :height, limit: 2, null: false
      t.timestamps
    end
  end
end
