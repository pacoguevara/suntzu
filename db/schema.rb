# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150806031851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "candidate_votations", force: true do |t|
    t.integer  "candidate_id"
    t.integer  "polling_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "candidate_votations", ["candidate_id"], name: "index_candidate_votations_on_candidate_id", using: :btree
  add_index "candidate_votations", ["polling_id"], name: "index_candidate_votations_on_polling_id", using: :btree

  create_table "candidates", force: true do |t|
    t.string   "name"
    t.integer  "age"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string  "name"
    t.integer "state_id"
    t.string  "key"
  end

  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "documents", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "doc_file_name"
    t.string   "doc_content_type"
    t.integer  "doc_file_size"
    t.datetime "doc_updated_at"
    t.string   "description"
  end

  add_index "documents", ["user_id"], name: "index_documents_on_user_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "candidate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["candidate_id"], name: "index_groups_on_candidate_id", using: :btree

  create_table "list_votation_headers", force: true do |t|
    t.integer "polling_id"
  end

  add_index "list_votation_headers", ["polling_id"], name: "index_list_votation_headers_on_polling_id", using: :btree

  create_table "list_votations", force: true do |t|
    t.integer  "list_votation_header_id"
    t.integer  "user_id"
    t.integer  "number"
    t.boolean  "check"
    t.datetime "created_at"
    t.datetime "update_at"
    t.datetime "updated_at"
  end

  add_index "list_votations", ["list_votation_header_id"], name: "index_list_votations_on_list_votation_header_id", using: :btree
  add_index "list_votations", ["user_id"], name: "index_list_votations_on_user_id", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "user_id"
    t.text     "message"
    t.string   "deep"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "militants", force: true do |t|
    t.datetime "register_date"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "name"
    t.datetime "bird"
    t.string   "rnm"
    t.string   "linking"
    t.string   "sub_linking"
    t.integer  "group_id"
    t.string   "suburb"
    t.string   "section"
    t.string   "sector"
    t.string   "cp"
    t.string   "phone"
    t.string   "cellphone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "militants", ["group_id"], name: "index_militants_on_group_id", using: :btree

  create_table "municipalities", id: false, force: true do |t|
    t.string   "id",         null: false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "municipalities", ["id"], name: "index_municipalities_on_id", unique: true, using: :btree

  create_table "pollings", force: true do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string "name"
  end

  create_table "user_messages", force: true do |t|
    t.boolean "is_sms"
    t.boolean "is_mail"
    t.integer "user_id"
    t.integer "message_id"
    t.string  "message_sid"
    t.string  "status"
  end

  add_index "user_messages", ["message_id"], name: "index_user_messages_on_message_id", using: :btree
  add_index "user_messages", ["user_id"], name: "index_user_messages_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "cellphone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rnm"
    t.integer  "parent"
    t.string   "section"
    t.string   "zipcode"
    t.string   "role"
    t.string   "cp"
    t.datetime "register_date"
    t.datetime "bird"
    t.string   "sector"
    t.string   "phone"
    t.integer  "age"
    t.string   "gender"
    t.string   "city"
    t.string   "street_number"
    t.string   "neighborhood"
    t.integer  "dto_fed"
    t.integer  "dto_loc"
    t.integer  "internal_number"
    t.string   "ife_key"
    t.integer  "outside_number"
    t.integer  "group_id"
    t.float    "lat"
    t.float    "lng"
    t.text     "fb"
    t.text     "tw"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "city_key"
    t.string   "municipality_id"
    t.boolean  "temp_chek"
    t.integer  "subenlace_id"
    t.integer  "enlace_id"
    t.integer  "coordinador_id"
    t.boolean  "enabled"
  end

  add_index "users", ["group_id"], name: "index_users_on_group_id", using: :btree
  add_index "users", ["ife_key"], name: "index_users_on_ife_key", unique: true, using: :btree
  add_index "users", ["municipality_id"], name: "index_users_on_municipality_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: true do |t|
    t.integer "user_id"
    t.integer "candidate_id"
    t.integer "polling_id"
  end

  add_index "votes", ["candidate_id"], name: "index_votes_on_candidate_id", using: :btree
  add_index "votes", ["polling_id"], name: "index_votes_on_polling_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

end
