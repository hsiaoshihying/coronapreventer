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

ActiveRecord::Schema.define(version: 2020_05_18_035934) do

  create_table "appointments", force: :cascade do |t|
    t.integer "customer_user_id"
    t.integer "store_user_id"
    t.integer "product_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "product_name"
    t.index ["customer_user_id"], name: "index_appointments_on_customer_user_id"
    t.index ["product_id"], name: "index_appointments_on_product_id"
    t.index ["store_user_id"], name: "index_appointments_on_store_user_id"
  end

  create_table "customer_users", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "mynumber"
    t.string "address"
    t.index "\"customer_user_id\", \"created_at\"", name: "index_customer_users_on_customer_user_id_and_created_at"
  end

  create_table "inquiries", force: :cascade do |t|
    t.text "content"
    t.text "reply", default: "None"
    t.integer "customer_user_id"
    t.integer "store_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_id"
    t.index ["customer_user_id"], name: "index_inquiries_on_customer_user_id"
    t.index ["product_id"], name: "index_inquiries_on_product_id"
    t.index ["store_user_id"], name: "index_inquiries_on_store_user_id"
  end

  create_table "personal_infos", force: :cascade do |t|
    t.string "mynumber"
    t.string "name"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.integer "total_num"
    t.integer "order_num", default: 0
    t.integer "store_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "\"product_id\"", name: "index_products_on_product_id"
    t.index ["store_user_id", "created_at"], name: "index_products_on_store_user_id_and_created_at"
    t.index ["store_user_id"], name: "index_products_on_store_user_id"
  end

  create_table "store_users", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "address"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index "\"store_user_id\"", name: "index_store_users_on_store_user_id"
    t.index ["email"], name: "index_store_users_on_email", unique: true
  end

  add_foreign_key "appointments", "customer_users"
  add_foreign_key "appointments", "products"
  add_foreign_key "appointments", "store_users"
  add_foreign_key "inquiries", "customer_users"
  add_foreign_key "inquiries", "products"
  add_foreign_key "inquiries", "store_users"
  add_foreign_key "products", "store_users"
end
