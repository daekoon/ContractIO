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

ActiveRecord::Schema.define(version: 2020_06_03_155033) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clause_templates", force: :cascade do |t|
    t.string "name"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "merge_tags", default: [], array: true
    t.string "explanation_text"
    t.string "tag"
  end

  create_table "clauses", force: :cascade do |t|
    t.string "name"
    t.string "tags", array: true
    t.string "text"
    t.string "explanation_text"
    t.boolean "custom"
    t.string "template_name"
  end

  create_table "contracts", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.string "lender_address"
    t.string "borrower_name"
    t.string "lender_name"
    t.string "borrower_address"
    t.bigint "loan_amount"
    t.integer "clauses", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "loan_duration"
    t.float "interest_rate"
    t.string "contract_type"
    t.json "data", default: {}
    t.index ["user_id", "created_at"], name: "index_contracts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_contracts_on_user_id"
  end

  create_table "terms", force: :cascade do |t|
    t.string "text"
    t.string "explanation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "contracts", "users"
end
