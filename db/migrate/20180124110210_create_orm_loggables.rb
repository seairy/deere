class CreateOrmLoggables < ActiveRecord::Migration[5.1]
  def change
    create_table :orm_loggables do |t|
      t.references :model, null: false
      t.boolean :on_create, null: false
      t.boolean :on_update, null: false
      t.boolean :on_destroy, null: false
      t.boolean :comment_required, null: false
      t.timestamps
    end
  end
end
