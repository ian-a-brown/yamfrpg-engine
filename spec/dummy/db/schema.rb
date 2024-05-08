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

ActiveRecord::Schema[7.1].define(version: 2024_05_05_033751) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "yamfrpg_engine_addresses", force: :cascade do |t|
    t.string "address_one"
    t.string "address_two"
    t.string "city"
    t.string "region"
    t.string "country"
    t.string "postal_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "yamfrpg_engine_person_names", force: :cascade do |t|
    t.string "given_name"
    t.string "middle_name"
    t.string "surname"
    t.integer "style"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "yamfrpg_engine_phone_numbers", force: :cascade do |t|
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "yamfrpg_engine_user_phone_numbers", force: :cascade do |t|
    t.bigint "phone_number_id", null: false
    t.bigint "user_id", null: false
    t.integer "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone_number_id"], name: "index_yamfrpg_engine_user_phone_numbers_on_phone_number_id"
    t.index ["user_id"], name: "index_yamfrpg_engine_user_phone_numbers_on_user_id"
  end

  create_table "yamfrpg_engine_users", force: :cascade do |t|
    t.bigint "address_id"
    t.bigint "person_name_id"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_yamfrpg_engine_users_on_address_id"
    t.index ["email"], name: "index_yamfrpg_engine_users_on_email", unique: true
    t.index ["person_name_id"], name: "index_yamfrpg_engine_users_on_person_name_id"
    t.index ["reset_password_token"], name: "index_yamfrpg_engine_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_yamfrpg_engine_users_on_unlock_token", unique: true
  end

  add_foreign_key "yamfrpg_engine_user_phone_numbers", "yamfrpg_engine_phone_numbers", column: "phone_number_id"
  add_foreign_key "yamfrpg_engine_user_phone_numbers", "yamfrpg_engine_users", column: "user_id"
  add_foreign_key "yamfrpg_engine_users", "yamfrpg_engine_addresses", column: "address_id"
  add_foreign_key "yamfrpg_engine_users", "yamfrpg_engine_person_names", column: "person_name_id"
end
