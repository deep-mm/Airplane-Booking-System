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

ActiveRecord::Schema.define(version: 2022_09_27_234840) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "baggages", force: :cascade do |t|
    t.decimal "weight"
    t.decimal "cost"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "reservation_id", null: false
    t.index ["reservation_id"], name: "index_baggages_on_reservation_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "flights", force: :cascade do |t|
    t.string "name"
    t.string "flight_class"
    t.string "manufacturer"
    t.integer "capacity"
    t.string "status"
    t.decimal "cost"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "origin_city_id"
    t.bigint "destination_city_id"
    t.index ["destination_city_id"], name: "index_flights_on_destination_city_id"
    t.index ["origin_city_id"], name: "index_flights_on_origin_city_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "passengers"
    t.string "reservation_class"
    t.string "amenities"
    t.decimal "cost"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "flight_id", null: false
    t.bigint "user_id", null: false
    t.string "confirmation_number"
    t.index ["flight_id"], name: "index_reservations_on_flight_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "credit_card"
    t.string "address"
    t.string "mobile"
    t.string "email"
    t.boolean "is_admin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
  end

  add_foreign_key "baggages", "reservations"
  add_foreign_key "flights", "cities", column: "destination_city_id"
  add_foreign_key "flights", "cities", column: "origin_city_id"
  add_foreign_key "reservations", "flights"
  add_foreign_key "reservations", "users"
end
