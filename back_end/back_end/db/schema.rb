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

ActiveRecord::Schema[7.0].define(version: 2023_12_19_091004) do
  create_table "carts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "product_id", null: false
    t.integer "number"
    t.datetime "addTime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_carts_on_product_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "product_id", null: false
    t.text "content"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_comments_on_product_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "followships", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "following_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["following_user_id"], name: "index_followships_on_following_user_id"
    t.index ["user_id"], name: "index_followships_on_user_id"
  end

  create_table "notice_records", force: :cascade do |t|
    t.integer "notice_id", null: false
    t.integer "user_id", null: false
    t.boolean "readed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notice_id"], name: "index_notice_records_on_notice_id"
    t.index ["user_id"], name: "index_notice_records_on_user_id"
  end

  create_table "notices", force: :cascade do |t|
    t.string "title"
    t.integer "notice_type"
    t.integer "user_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notices_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "number"
    t.string "state"
    t.integer "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "product_details", force: :cascade do |t|
    t.integer "product_id", null: false
    t.text "product_name"
    t.string "product_image"
    t.text "product_press"
    t.string "product_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_details_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "user_id", null: false
    t.decimal "price"
    t.text "sell_address"
    t.integer "store"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "check_state"
    t.decimal "score_per"
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "user_details", force: :cascade do |t|
    t.string "password"
    t.string "user_name"
    t.text "buy_address"
    t.string "gender"
    t.text "pay_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.string "avatar"
    t.index ["user_id"], name: "index_user_details_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "right"
  end

  create_table "wallets", force: :cascade do |t|
    t.integer "user_id", null: false
    t.decimal "money_sum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "carts", "products"
  add_foreign_key "carts", "users"
  add_foreign_key "comments", "products"
  add_foreign_key "comments", "users"
  add_foreign_key "followships", "users"
  add_foreign_key "followships", "users", column: "following_user_id"
  add_foreign_key "notice_records", "notices"
  add_foreign_key "notice_records", "users"
  add_foreign_key "notices", "users"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "product_details", "products"
  add_foreign_key "products", "users"
  add_foreign_key "user_details", "users"
  add_foreign_key "wallets", "users"
end
