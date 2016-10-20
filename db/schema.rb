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

ActiveRecord::Schema.define(version: 20161018205855) do

  create_table "bugs", force: true do |t|
    t.string   "application_token", null: false
    t.integer  "number",            null: false
    t.integer  "status",            null: false
    t.integer  "priority",          null: false
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bugs", ["application_token", "number"], name: "index_bugs_on_application_token_and_number", unique: true, using: :btree

  create_table "states", force: true do |t|
    t.integer  "bug_id",     null: false
    t.string   "device"
    t.string   "os"
    t.integer  "memory"
    t.integer  "storage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
