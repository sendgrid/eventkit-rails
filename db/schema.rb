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

ActiveRecord::Schema.define(version: 20141014135702) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.integer  "timestamp",            limit: 8
    t.text     "event"
    t.text     "email"
    t.text     "smtp-id"
    t.text     "sg_event_id"
    t.text     "sg_message_id"
    t.text     "category"
    t.text     "newsletter"
    t.text     "response"
    t.text     "reason"
    t.text     "ip"
    t.text     "useragent"
    t.text     "attempt"
    t.text     "status"
    t.text     "type_id"
    t.text     "url"
    t.text     "additional_arguments"
    t.integer  "event_post_timestamp", limit: 8
    t.text     "raw"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "asm_group_id",         limit: 2
  end

  create_table "settings", force: true do |t|
    t.string   "name"
    t.text     "value"
    t.integer  "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.integer  "permissions",   default: 1
    t.string   "token"
    t.integer  "token_expires", default: 0
    t.string   "username"
    t.binary   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
