# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_27_175121) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batches", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.string "customer_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.bigint "batch_id", null: false
    t.integer "quantity", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["batch_id"], name: "index_items_on_batch_id"
  end

  add_foreign_key "items", "batches"
  create_trigger("items_after_insert_update_row_tr", :generated => true, :compatibility => 1).
      on("items").
      after(:insert, :update) do
    <<-SQL_ACTIONS
      PERFORM pg_notify('change_record', '{klass_name: items, crud_method: create_or_update, record_id: ' || COALESCE(NEW.id, 0) || '}');
      RETURN NEW;
    SQL_ACTIONS
  end

  create_trigger("items_after_delete_row_tr", :generated => true, :compatibility => 1).
      on("items").
      after(:delete) do
    <<-SQL_ACTIONS
      PERFORM pg_notify('change_record', '{klass_name: items, crud_method: delete, record_id: ' || COALESCE(OLD.id, 0) || '}');
      RETURN OLD;
    SQL_ACTIONS
  end

end
