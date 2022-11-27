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

ActiveRecord::Schema.define(version: 2022_11_27_200623) do

  create_table "admins", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "attempts", force: :cascade do |t|
    t.integer "group_id"
    t.integer "asked_questions_count"
    t.boolean "opened_pulseoximetr"
    t.boolean "opened_ekg"
    t.boolean "opened_glukometr"
    t.boolean "opened_trop_test"
    t.string "main_diagnosis"
    t.string "diagnosis_complications"
    t.string "diagnosis_accompanying_illnesses"
    t.json "treatment_medicate"
    t.string "treatment_non_medicate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "phone"
    t.string "email"
    t.index ["group_id"], name: "index_attempts_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "custom_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
