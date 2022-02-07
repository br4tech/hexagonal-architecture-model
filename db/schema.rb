# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_02_07_125840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accesses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "office_id", null: false
    t.boolean "allow", default: false
    t.index ["office_id"], name: "index_accesses_on_office_id"
    t.index ["user_id"], name: "index_accesses_on_user_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "attendances", force: :cascade do |t|
    t.bigint "contract_id", null: false
    t.bigint "clinic_id", null: false
    t.bigint "office_id"
    t.integer "weekdays", array: true
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.boolean "is_recurrent", default: false
    t.time "time_starts"
    t.time "time_ends"
    t.integer "frequency"
    t.decimal "amount", precision: 8, scale: 2
    t.index ["clinic_id"], name: "index_attendances_on_clinic_id"
    t.index ["contract_id"], name: "index_attendances_on_contract_id"
    t.index ["office_id"], name: "index_attendances_on_office_id"
  end

  create_table "client_doctors", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "doctor_id", null: false
    t.index ["client_id"], name: "index_client_doctors_on_client_id"
    t.index ["doctor_id"], name: "index_client_doctors_on_doctor_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "kind"
    t.string "phone"
    t.boolean "status"
    t.string "document"
    t.string "zipcode"
    t.string "street"
    t.string "number"
    t.string "complement"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "clinics", force: :cascade do |t|
    t.bigint "office_id", null: false
    t.string "code"
    t.integer "status"
    t.decimal "price", precision: 15, scale: 2
    t.string "metrics"
    t.string "medical_specialties"
    t.string "color"
    t.index ["office_id"], name: "index_clinics_on_office_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "document"
    t.integer "wallet"
    t.integer "agency"
    t.integer "current_account"
    t.integer "digit"
    t.string "company_code"
    t.integer "shipping_sequence"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "category"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "address"
    t.string "neighborhood"
  end

  create_table "contract_combos", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.index ["client_id"], name: "index_contract_combos_on_client_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.decimal "amount", precision: 8, scale: 2
    t.integer "revenues_at"
    t.integer "due_at"
    t.decimal "forfeit", precision: 8, scale: 2
    t.integer "kind"
    t.integer "rescheduling_allowed"
    t.boolean "parking", default: false
    t.string "car_license_plate"
    t.integer "category", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "contract_combo_id"
    t.decimal "parking_value", precision: 8, scale: 2
    t.integer "rescheduling_used", default: 0
    t.index ["client_id"], name: "index_contracts_on_client_id"
    t.index ["contract_combo_id"], name: "index_contracts_on_contract_combo_id"
  end

  create_table "day_offs", force: :cascade do |t|
    t.datetime "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "holiday_id", null: false
    t.string "description"
    t.string "color"
    t.index ["holiday_id"], name: "index_day_offs_on_holiday_id"
  end

  create_table "discounts", force: :cascade do |t|
    t.decimal "amount", precision: 15, scale: 2
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.bigint "contract_id", null: false
    t.index ["contract_id"], name: "index_discounts_on_contract_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.string "document"
    t.string "crm"
    t.integer "gender"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "zipcode"
    t.string "address"
    t.integer "number"
    t.string "complement"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.bigint "client_id"
    t.index ["client_id"], name: "index_doctors_on_client_id"
  end

  create_table "expertises", force: :cascade do |t|
    t.string "name"
    t.bigint "doctor_id", null: false
    t.string "duration"
    t.decimal "price", precision: 15, scale: 2
    t.integer "days_to_return", default: 15
    t.boolean "returns", default: true
    t.boolean "confirm", default: true
    t.text "observations"
    t.index ["doctor_id"], name: "index_expertises_on_doctor_id"
  end

  create_table "holidays", force: :cascade do |t|
    t.string "name"
    t.text "color"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "medical_infos", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.text "health_care"
    t.integer "payment_methods", array: true
    t.boolean "pay_first", default: false
    t.integer "receipt_type"
    t.index ["client_id"], name: "index_medical_infos_on_client_id"
    t.index ["payment_methods"], name: "index_medical_infos_on_payment_methods", using: :gin
  end

  create_table "offices", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.text "address"
    t.string "phone"
    t.string "phone_secondary"
    t.integer "status", default: 0
    t.text "opening_hours"
    t.integer "weekdays", array: true
    t.datetime "start_at"
    t.datetime "end_at"
  end

  create_table "payroll_items", force: :cascade do |t|
    t.date "period"
    t.bigint "clinic_id", null: false
    t.integer "hours"
    t.decimal "amount", precision: 15, scale: 4
    t.bigint "payroll_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "reservations_id", null: false
    t.boolean "odd", default: false
    t.index ["clinic_id"], name: "index_payroll_items_on_clinic_id"
    t.index ["payroll_id"], name: "index_payroll_items_on_payroll_id"
    t.index ["reservations_id"], name: "index_payroll_items_on_reservations_id"
  end

  create_table "payrolls", force: :cascade do |t|
    t.date "emission"
    t.bigint "contract_id", null: false
    t.datetime "ends_at"
    t.date "due_at"
    t.boolean "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "starts_at"
    t.date "revenues_at"
    t.decimal "parking_value", precision: 8, scale: 2, default: "0.0"
    t.index ["contract_id"], name: "index_payrolls_on_contract_id"
  end

  create_table "person_kinds", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rescheduling_alloweds", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.integer "used", default: 0
    t.integer "available", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_rescheduling_alloweds_on_client_id"
  end

  create_table "reservation_availables", force: :cascade do |t|
    t.datetime "date"
    t.bigint "clinic_id", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "available", default: true
    t.index ["clinic_id"], name: "index_reservation_availables_on_clinic_id"
  end

  create_table "reservation_without_contracts", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.datetime "date"
    t.bigint "office_id", null: false
    t.bigint "clinic_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.index ["client_id"], name: "index_reservation_without_contracts_on_client_id"
    t.index ["clinic_id"], name: "index_reservation_without_contracts_on_clinic_id"
    t.index ["office_id"], name: "index_reservation_without_contracts_on_office_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.date "date"
    t.bigint "office_id", null: false
    t.bigint "clinic_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean "odd", default: false
    t.integer "category"
    t.boolean "canceled", default: false
    t.bigint "attendance_id", null: false
    t.index ["attendance_id"], name: "index_reservations_on_attendance_id"
    t.index ["clinic_id"], name: "index_reservations_on_clinic_id"
    t.index ["office_id"], name: "index_reservations_on_office_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.integer "role", default: 2
    t.string "document"
    t.string "phone"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accesses", "offices"
  add_foreign_key "accesses", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "attendances", "clinics"
  add_foreign_key "attendances", "contracts"
  add_foreign_key "client_doctors", "clients"
  add_foreign_key "client_doctors", "doctors"
  add_foreign_key "clinics", "offices"
  add_foreign_key "contract_combos", "clients"
  add_foreign_key "contracts", "clients"
  add_foreign_key "contracts", "contract_combos"
  add_foreign_key "day_offs", "holidays"
  add_foreign_key "discounts", "contracts"
  add_foreign_key "doctors", "clients"
  add_foreign_key "expertises", "doctors"
  add_foreign_key "medical_infos", "clients"
  add_foreign_key "payroll_items", "clinics"
  add_foreign_key "payroll_items", "payrolls"
  add_foreign_key "payroll_items", "reservations", column: "reservations_id"
  add_foreign_key "payrolls", "contracts"
  add_foreign_key "rescheduling_alloweds", "clients"
  add_foreign_key "reservation_without_contracts", "clients"
  add_foreign_key "reservation_without_contracts", "clinics"
  add_foreign_key "reservation_without_contracts", "offices"
  add_foreign_key "reservations", "attendances"
  add_foreign_key "reservations", "clinics"
  add_foreign_key "reservations", "offices"
end
