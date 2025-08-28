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

ActiveRecord::Schema[8.0].define(version: 2025_08_28_075127) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "booked_date"
    t.datetime "available_date"
    t.integer "status"
    t.text "description"
    t.integer "booking_number"
    t.bigint "patient_id", null: false
    t.bigint "doctor_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "doctor_time_slot_id"
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["doctor_time_slot_id"], name: "index_appointments_on_doctor_time_slot_id"
    t.index ["location_id"], name: "index_appointments_on_location_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
  end

  create_table "doctor_time_slots", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "date"
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_doctor_time_slots_on_doctor_id"
    t.index ["location_id"], name: "index_doctor_time_slots_on_location_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.bigint "phone_number"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "medical_unit_id", null: false
    t.index ["medical_unit_id"], name: "index_doctors_on_medical_unit_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "country"
    t.integer "zip_code"
    t.bigint "medical_unit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medical_unit_id"], name: "index_locations_on_medical_unit_id"
  end

  create_table "medical_units", force: :cascade do |t|
    t.string "name"
    t.integer "unit_type"
    t.bigint "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patients", force: :cascade do |t|
    t.bigint "phone_number"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "specializations", force: :cascade do |t|
    t.string "specialization_category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "specialized_doctors", force: :cascade do |t|
    t.bigint "specialization_id", null: false
    t.bigint "doctor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_specialized_doctors_on_doctor_id"
    t.index ["specialization_id"], name: "index_specialized_doctors_on_specialization_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role"
    t.string "firstname"
    t.string "lastname"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "appointments", "doctor_time_slots"
  add_foreign_key "appointments", "doctors"
  add_foreign_key "appointments", "locations"
  add_foreign_key "appointments", "patients"
  add_foreign_key "doctor_time_slots", "doctors"
  add_foreign_key "doctor_time_slots", "locations"
  add_foreign_key "doctors", "medical_units"
  add_foreign_key "locations", "medical_units"
  add_foreign_key "specialized_doctors", "doctors"
  add_foreign_key "specialized_doctors", "specializations"
end
