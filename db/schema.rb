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

ActiveRecord::Schema[7.1].define(version: 2023_01_07_212454) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "status", ["pending", "processing", "processed", "failed"]

  create_table "accounts", force: :cascade do |t|
    t.string "stripe_id"
    t.boolean "payouts_enabled"
    t.boolean "charges_enabled"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "financial_account_id"
    t.string "external_account_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "attachment_views", force: :cascade do |t|
    t.bigint "attachment_id", null: false
    t.bigint "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attachment_id"], name: "index_attachment_views_on_attachment_id"
    t.index ["customer_id"], name: "index_attachment_views_on_customer_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "name"
    t.integer "views_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_attachments_on_product_id"
  end

  create_table "customer_products", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "product_id", null: false
    t.string "checkout_session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id", "product_id", "checkout_session_id"], name: "customer_product_session_index", unique: true
    t.index ["customer_id"], name: "index_customer_products_on_customer_id"
    t.index ["product_id"], name: "index_customer_products_on_product_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "stripe_id"
    t.string "email"
    t.bigint "store_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id", "email"], name: "index_customers_on_store_id_and_email", unique: true
    t.index ["store_id"], name: "index_customers_on_store_id"
  end

  create_table "events", force: :cascade do |t|
    t.json "data"
    t.string "source"
    t.text "processing_errors"
    t.enum "status", default: "pending", null: false, enum_type: "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "stripe_id"
    t.string "stripe_price_id"
    t.json "data"
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "subdomain"
    t.string "domain"
    t.string "primary_color"
    t.string "secondary_color"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stores_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "attachment_views", "attachments"
  add_foreign_key "attachment_views", "customers"
  add_foreign_key "attachments", "products"
  add_foreign_key "customer_products", "customers"
  add_foreign_key "customer_products", "products"
  add_foreign_key "customers", "stores"
  add_foreign_key "products", "users"
  add_foreign_key "stores", "users"
end
