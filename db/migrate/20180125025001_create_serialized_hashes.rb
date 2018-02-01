class CreateSerializedHashes < ActiveRecord::Migration[5.1]
  def change
    create_table :serialized_hashes do |t|
      t.references :hash_property, null: false
      t.string :name, limit: 100, null: false
      t.timestamps
    end
  end
end
