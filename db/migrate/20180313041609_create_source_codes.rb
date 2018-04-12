class CreateSourceCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :source_codes do |t|
      t.references :project, null: false
      t.string :prefix, limit: 1000, null: false
      t.string :file_name, limit: 255, null: false
      t.string :extension, limit: 50, null: false
      t.text :content, null: false
      t.timestamps
    end
  end
end
