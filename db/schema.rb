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

ActiveRecord::Schema.define(version: 2022_04_23_103517) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.integer "followers"
    t.integer "popularity"
    t.string "spotify_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "month_streaming_imports", force: :cascade do |t|
    t.string "file"
    t.bigint "artist_id", null: false
    t.datetime "ran_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_id"], name: "index_month_streaming_imports_on_artist_id"
  end

  create_table "monthly_streamings", force: :cascade do |t|
    t.integer "month"
    t.integer "year"
    t.integer "streams", default: 0
    t.integer "listeners", default: 0
    t.integer "followers", default: 0
    t.bigint "artist_id", null: false
    t.bigint "month_streaming_import_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_id"], name: "index_monthly_streamings_on_artist_id"
    t.index ["month_streaming_import_id"], name: "index_monthly_streamings_on_month_streaming_import_id"
  end

  create_table "playlist_data", force: :cascade do |t|
    t.integer "month", null: false
    t.integer "year", null: false
    t.bigint "playlist_id", null: false
    t.bigint "artist_id", null: false
    t.bigint "playlist_data_import_id", null: false
    t.integer "streams"
    t.integer "listeners"
    t.integer "followers"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_id"], name: "index_playlist_data_on_artist_id"
    t.index ["playlist_data_import_id"], name: "index_playlist_data_on_playlist_data_import_id"
    t.index ["playlist_id"], name: "index_playlist_data_on_playlist_id"
  end

  create_table "playlist_data_imports", force: :cascade do |t|
    t.string "file"
    t.bigint "artist_id", null: false
    t.integer "month", null: false
    t.integer "year", null: false
    t.datetime "ran_at"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_id"], name: "index_playlist_data_imports_on_artist_id"
    t.index ["user_id"], name: "index_playlist_data_imports_on_user_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name", null: false
    t.string "author", null: false
    t.string "mood"
    t.string "genre"
    t.text "description"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "releases", force: :cascade do |t|
    t.datetime "released_at"
    t.bigint "artist_id", null: false
    t.string "image_url"
    t.string "spotify_id"
    t.string "release_type", null: false
    t.string "title", null: false
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_id"], name: "index_releases_on_artist_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "month_streaming_imports", "artists"
  add_foreign_key "monthly_streamings", "artists"
  add_foreign_key "monthly_streamings", "month_streaming_imports"
  add_foreign_key "playlist_data", "artists"
  add_foreign_key "playlist_data", "playlist_data_imports"
  add_foreign_key "playlist_data", "playlists"
  add_foreign_key "playlist_data_imports", "artists"
  add_foreign_key "playlist_data_imports", "users"
  add_foreign_key "releases", "artists"
end
