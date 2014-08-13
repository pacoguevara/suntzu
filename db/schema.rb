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

ActiveRecord::Schema.define(version: 20140813014351) do

  create_table "candidate_votations", force: true do |t|
    t.integer  "candidate_id"
    t.integer  "polling_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "candidate_votations", ["candidate_id"], name: "index_candidate_votations_on_candidate_id"
  add_index "candidate_votations", ["polling_id"], name: "index_candidate_votations_on_polling_id"

  create_table "candidates", force: true do |t|
    t.string   "name"
    t.integer  "age"
    t.string   "sex"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string  "name"
    t.integer "state_id"
  end

  add_index "cities", ["state_id"], name: "index_cities_on_state_id"

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "candidate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["candidate_id"], name: "index_groups_on_candidate_id"

  create_table "messages", force: true do |t|
    t.text    "message"
    t.string  "depth"
    t.integer "user_id"
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

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

  add_index "militants", ["group_id"], name: "index_militants_on_group_id"

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
  end

  add_index "user_messages", ["message_id"], name: "index_user_messages_on_message_id"
  add_index "user_messages", ["user_id"], name: "index_user_messages_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votes", force: true do |t|
    t.integer "militant_id"
    t.integer "candidate_id"
    t.integer "polling_id"
  end

  add_index "votes", ["candidate_id"], name: "index_votes_on_candidate_id"
  add_index "votes", ["militant_id"], name: "index_votes_on_militant_id"
  add_index "votes", ["polling_id"], name: "index_votes_on_polling_id"

end
