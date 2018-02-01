# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180129114055) do

  create_table "absence_validations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_absence_validations_on_property_id"
  end

  create_table "acceptance_validations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "property_id", null: false
    t.string "accept", limit: 25
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_acceptance_validations_on_property_id"
  end

  create_table "authenticatables", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "model_id", null: false
    t.string "account_field_name", limit: 25, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_id"], name: "index_authenticatables_on_model_id"
  end

  create_table "cascade_redundancies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "cascade_id", null: false
    t.bigint "model_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cascade_id"], name: "index_cascade_redundancies_on_cascade_id"
    t.index ["model_id"], name: "index_cascade_redundancies_on_model_id"
  end

  create_table "cascades", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "source_id", null: false
    t.bigint "destination_id", null: false
    t.string "type", limit: 50, null: false
    t.boolean "optional", null: false
    t.string "source_alias_name", limit: 100
    t.string "destination_alias_name", limit: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destination_id"], name: "index_cascades_on_destination_id"
    t.index ["source_id"], name: "index_cascades_on_source_id"
  end

  create_table "common_validations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "property_id", null: false
    t.string "empty_tolerance", limit: 25, null: false
    t.string "on_actions", limit: 25, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_common_validations_on_property_id"
  end

  create_table "confirmation_validations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "property_id", null: false
    t.boolean "case_sensitive", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_confirmation_validations_on_property_id"
  end

  create_table "enumeration_elements", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "enumeration_property_id"
    t.string "name", limit: 50, null: false
    t.string "zh_name", limit: 50, null: false
    t.string "en_name", limit: 50, null: false
    t.integer "position", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enumeration_property_id"], name: "index_enumeration_elements_on_enumeration_property_id"
  end

  create_table "exclusion_validations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "property_id", null: false
    t.string "values", limit: 1000, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_exclusion_validations_on_property_id"
  end

  create_table "format_validations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "property_id", null: false
    t.string "regular_expression", limit: 500, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_format_validations_on_property_id"
  end

  create_table "image_uploaders", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "file_property_id", null: false
    t.integer "quality", limit: 1, null: false
    t.string "resize_method", limit: 4, null: false
    t.integer "width", limit: 2, null: false
    t.integer "height", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["file_property_id"], name: "index_image_uploaders_on_file_property_id"
  end

  create_table "inclusion_validations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "property_id", null: false
    t.string "values", limit: 1000, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_inclusion_validations_on_property_id"
  end

  create_table "length_validations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "property_id", null: false
    t.integer "minimum"
    t.integer "maximum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_length_validations_on_property_id"
  end

  create_table "models", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "project_id", null: false
    t.string "name", limit: 100, null: false
    t.string "zh_name", limit: 100, null: false
    t.string "en_name", limit: 100, null: false
    t.string "includes_classes", limit: 1000
    t.string "extends_classes", limit: 1000
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_models_on_project_id"
  end

  create_table "numericality_validations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "property_id", null: false
    t.decimal "minimum", precision: 64, scale: 30
    t.boolean "includes_minimum"
    t.integer "maximum"
    t.boolean "includes_maximum"
    t.boolean "only_integer", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_numericality_validations_on_property_id"
  end

  create_table "orm_loggables", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "model_id", null: false
    t.boolean "on_create", null: false
    t.boolean "on_update", null: false
    t.boolean "on_destroy", null: false
    t.boolean "comment_required", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_id"], name: "index_orm_loggables_on_model_id"
  end

  create_table "presence_validations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_presence_validations_on_property_id"
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", limit: 100, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "properties", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "inheritance_type", limit: 25, null: false
    t.bigint "model_id", null: false
    t.string "name", limit: 100, null: false
    t.string "zh_name", limit: 100, null: false
    t.string "en_name", limit: 100, null: false
    t.string "type", limit: 50, null: false
    t.integer "precision", limit: 1
    t.integer "scale", limit: 1
    t.integer "position", limit: 3, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_id"], name: "index_properties_on_model_id"
  end

  create_table "serialized_hashes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "hash_property_id", null: false
    t.string "name", limit: 100, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hash_property_id"], name: "index_serialized_hashes_on_hash_property_id"
  end

  create_table "sortables", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "model_id", null: false
    t.string "scope", limit: 25
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_id"], name: "index_sortables_on_model_id"
  end

  create_table "state_machine_events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "state_machine_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_machine_id"], name: "index_state_machine_events_on_state_machine_id"
  end

  create_table "state_machine_states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "state_machine_id", null: false
    t.string "name", limit: 200, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_machine_id"], name: "index_state_machine_states_on_state_machine_id"
  end

  create_table "state_machines", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "model_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_id"], name: "index_state_machines_on_model_id"
  end

  create_table "trashables", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "model_id", null: false
    t.boolean "default_without_trashed", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_id"], name: "index_trashables_on_model_id"
  end

  create_table "uniqueness_validations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "property_id", null: false
    t.string "scopes", limit: 1000
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["property_id"], name: "index_uniqueness_validations_on_property_id"
  end

  create_table "versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "project_id", null: false
    t.integer "major", limit: 2, null: false
    t.integer "minor", limit: 2, null: false
    t.integer "patch", limit: 2, null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_versions_on_project_id"
  end

end
