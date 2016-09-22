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

ActiveRecord::Schema.define(version: 20160921182149) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amenities", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "category"
  end

  create_table "authentications", force: :cascade do |t|
    t.string   "uid"
    t.string   "token"
    t.string   "provider"
    t.string   "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "listing_amenities", force: :cascade do |t|
    t.integer "listing_id"
    t.integer "amenity_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string   "name"
    t.string   "about"
    t.string   "location"
    t.string   "bed_type"
    t.string   "property_type"
    t.string   "room_type"
    t.string   "check_in_time"
    t.string   "check_out_time"
    t.string   "reserved_dates"
    t.integer  "owner_id"
    t.integer  "price"
    t.integer  "capacity"
    t.integer  "bathrooms"
    t.integer  "bedrooms"
    t.integer  "beds"
    t.integer  "instant_book"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "image"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
