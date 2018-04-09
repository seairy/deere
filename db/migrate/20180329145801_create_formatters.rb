class CreateFormatters < ActiveRecord::Migration[5.1]
  def change
    create_table :formatters do |t|
      t.string :inheritance_type, limit: 50, null: false
      t.references :formattable, polymorphic: true, null: false
      t.integer :maximum_length
      t.boolean :includes_sign
      t.string :placeholder, limit: 100
      t.integer :precision
      t.boolean :strip_insignificant_zeros
      t.string :delimiter, limit: 100
      t.timestamps
    end
  end
end
