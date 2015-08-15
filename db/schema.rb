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


ActiveRecord::Schema.define(version: 20150815174654) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "historicals", force: :cascade do |t|
    t.integer  "search_id",          null: false
    t.string   "type_of_service"
    t.integer  "availability"
    t.string   "city_name"
    t.decimal  "avg_price_per_mile"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "searches", force: :cascade do |t|
    t.string   "origin",      null: false
    t.string   "destination", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "taxis", force: :cascade do |t|
    t.string   "city_name"
    t.integer  "initial_charge"
    t.integer  "per_mile_charge"
    t.integer  "typical_short_fare"
    t.integer  "typical_medium_fare"
    t.integer  "typical_long_fare"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",           null: false
    t.string   "password_digest"
    t.integer  "uber_key"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
