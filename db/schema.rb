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

ActiveRecord::Schema.define(version: 20171004114808) do

  create_table "active_admin_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "namespace"
    t.text     "body",          limit: 65535
    t.string   "resource_id",                 null: false
    t.string   "resource_type",               null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "albums", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "content_id"
    t.index ["content_id"], name: "index_albums_on_content_id", using: :btree
  end

  create_table "band_genres", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "band_genres_content", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "content_id",    null: false
    t.integer "band_genre_id", null: false
  end

  create_table "book_genres", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_genres_content", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "content_id",    null: false
    t.integer "book_genre_id", null: false
  end

  create_table "content", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "year"
    t.string   "info"
    t.integer  "timing"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "content_game_genres", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "content_id",    null: false
    t.integer "game_genre_id", null: false
  end

  create_table "content_movie_genres", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "content_id",     null: false
    t.integer "movie_genre_id", null: false
  end

  create_table "content_personalities", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "content_id",     null: false
    t.integer "personality_id", null: false
  end

  create_table "content_platforms", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "content_id",  null: false
    t.integer "platform_id", null: false
  end

  create_table "content_posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "content_id"
    t.integer  "post_id"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_content_posts_on_content_id", using: :btree
    t.index ["post_id"], name: "index_content_posts_on_post_id", using: :btree
  end

  create_table "content_rates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "content_id"
    t.integer  "user_id"
    t.integer  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_content_rates_on_content_id", using: :btree
    t.index ["user_id"], name: "index_content_rates_on_user_id", using: :btree
  end

  create_table "content_review_votes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "content_review_id"
    t.integer  "vote"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["content_review_id"], name: "index_content_review_votes_on_content_review_id", using: :btree
    t.index ["user_id", "content_review_id"], name: "idx_crvotes_user_cr", unique: true, using: :btree
    t.index ["user_id"], name: "index_content_review_votes_on_user_id", using: :btree
  end

  create_table "content_reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "body",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id"
    t.integer  "content_id"
    t.index ["content_id"], name: "index_content_reviews_on_content_id", using: :btree
    t.index ["user_id"], name: "index_content_reviews_on_user_id", using: :btree
  end

  create_table "game_genres", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movie_genres", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "personalities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.date     "born_date"
    t.date     "death_date"
    t.text     "info",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "personality_rates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "personality_id"
    t.integer  "user_id"
    t.integer  "value"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["personality_id"], name: "index_personality_rates_on_personality_id", using: :btree
    t.index ["user_id"], name: "index_personality_rates_on_user_id", using: :btree
  end

  create_table "personality_review_votes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "personality_review_id"
    t.integer  "vote"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["personality_review_id"], name: "index_personality_review_votes_on_personality_review_id", using: :btree
    t.index ["user_id", "personality_review_id"], name: "idx_prvotes_user_pr", unique: true, using: :btree
    t.index ["user_id"], name: "index_personality_review_votes_on_user_id", using: :btree
  end

  create_table "personality_reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "body",           limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "user_id"
    t.integer  "personality_id"
    t.index ["personality_id"], name: "index_personality_reviews_on_personality_id", using: :btree
    t.index ["user_id"], name: "index_personality_reviews_on_user_id", using: :btree
  end

  create_table "platforms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "author_id"
    t.index ["author_id"], name: "index_posts_on_author_id", using: :btree
  end

  create_table "posts_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_posts_users_on_post_id", using: :btree
    t.index ["user_id"], name: "index_posts_users_on_user_id", using: :btree
  end

  create_table "posts_users_likes", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.index ["post_id"], name: "index_posts_users_likes_on_post_id", using: :btree
    t.index ["user_id"], name: "index_posts_users_likes_on_user_id", using: :btree
  end

  create_table "profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "city"
    t.string   "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "tracks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "album_id"
    t.integer  "duration"
    t.index ["album_id"], name: "index_tracks_on_album_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "role"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "albums", "content"
  add_foreign_key "content_posts", "content"
  add_foreign_key "content_posts", "posts"
  add_foreign_key "content_rates", "content"
  add_foreign_key "content_rates", "users"
  add_foreign_key "content_review_votes", "content_reviews"
  add_foreign_key "content_review_votes", "users"
  add_foreign_key "content_reviews", "content"
  add_foreign_key "content_reviews", "users"
  add_foreign_key "personality_rates", "personalities"
  add_foreign_key "personality_rates", "users"
  add_foreign_key "personality_review_votes", "personality_reviews"
  add_foreign_key "personality_review_votes", "users"
  add_foreign_key "personality_reviews", "personalities"
  add_foreign_key "personality_reviews", "users"
  add_foreign_key "posts", "users", column: "author_id"
  add_foreign_key "posts_users", "posts"
  add_foreign_key "posts_users", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "tracks", "albums"
end
