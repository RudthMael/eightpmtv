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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110329185920) do

  create_table "activities", :force => true do |t|
    t.integer  "actor_id"
    t.string   "actor_type"
    t.string   "actor_path"
    t.string   "actor_name"
    t.string   "actor_img"
    t.string   "kind"
    t.text     "data",         :limit => 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subject_id"
    t.string   "subject_type"
    t.string   "subject_path"
    t.string   "subject_name"
    t.string   "subject_img"
  end

  add_index "activities", ["actor_type", "actor_id"], :name => "altered_activities_actor_type_actor_id_ix"
  add_index "activities", ["created_at"], :name => "altered_activities_created_at_ix"

  create_table "actors", :force => true do |t|
    t.integer  "tvdb_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "application_settings", :force => true do |t|
    t.string   "last_update"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
  end

  add_index "authentications", ["user_id"], :name => "authentications_user_id_ix"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "comments_commentable_id_ix"
  add_index "comments", ["commentable_type", "commentable_id"], :name => "comments_commentable_type_commentable_id_ix"
  add_index "comments", ["commentable_type"], :name => "comments_commentable_type_ix"
  add_index "comments", ["user_id"], :name => "comments_user_id_ix"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["locked_by"], :name => "delayed_jobs_locked_by"
  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "episodes", :force => true do |t|
    t.integer  "tvdb_id"
    t.integer  "season_id"
    t.integer  "number"
    t.date     "first_aired"
    t.text     "description"
    t.string   "name"
    t.string   "director"
    t.string   "writer"
    t.boolean  "poster_processing"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "poster_file_name"
    t.string   "poster_content_type"
    t.integer  "poster_file_size"
    t.datetime "poster_updated_at"
  end

  add_index "episodes", ["season_id"], :name => "episodes_season_id_ix"

  create_table "follows", :force => true do |t|
    t.integer  "followable_id",                      :null => false
    t.string   "followable_type",                    :null => false
    t.integer  "follower_id",                        :null => false
    t.string   "follower_type",                      :null => false
    t.boolean  "blocked",         :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], :name => "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], :name => "fk_follows"

  create_table "genres", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genres_series", :id => false, :force => true do |t|
    t.integer  "genre_id"
    t.integer  "series_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "genres_series", ["genre_id"], :name => "genres_series_genre_id_ix"
  add_index "genres_series", ["series_id"], :name => "genres_series_series_id_ix"

  create_table "likes", :force => true do |t|
    t.integer  "value",         :default => 0
    t.integer  "user_id"
    t.integer  "likeable_id"
    t.string   "likeable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["likeable_id"], :name => "likes_likeable_id_ix"
  add_index "likes", ["likeable_type", "likeable_id"], :name => "likes_likeable_type_likeable_id_ix"
  add_index "likes", ["likeable_type"], :name => "likes_likeable_type_ix"
  add_index "likes", ["user_id"], :name => "likes_user_id_ix"

  create_table "ratings", :force => true do |t|
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.integer  "user_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "series_id"
    t.integer  "actor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "roles", ["actor_id"], :name => "roles_actor_id_ix"
  add_index "roles", ["series_id"], :name => "roles_series_id_ix"

  create_table "seasons", :force => true do |t|
    t.integer  "number"
    t.integer  "tvdb_id"
    t.integer  "series_id"
    t.boolean  "poster_processing"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "poster_file_name"
    t.string   "poster_content_type"
    t.integer  "poster_file_size"
    t.datetime "poster_updated_at"
  end

  add_index "seasons", ["series_id"], :name => "seasons_series_id_ix"

  create_table "seens", :force => true do |t|
    t.integer  "user_id"
    t.integer  "seenable_id"
    t.string   "seenable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "series", :force => true do |t|
    t.integer  "tvdb_id"
    t.string   "air_day"
    t.string   "air_time"
    t.string   "content_rating"
    t.date     "first_aired"
    t.string   "imdb_id"
    t.string   "network"
    t.string   "description",         :limit => 3072
    t.decimal  "rating"
    t.integer  "rating_count"
    t.integer  "runtime"
    t.integer  "series_id"
    t.string   "name"
    t.string   "status"
    t.string   "banner"
    t.string   "fanart"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_updated_at"
    t.string   "poster_file_name"
    t.string   "poster_content_type"
    t.integer  "poster_file_size"
    t.datetime "poster_updated_at"
    t.boolean  "poster_processing"
    t.boolean  "seasons_processing"
    t.string   "name_prefix",                         :default => ""
    t.integer  "follows_count",                       :default => 0
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "settings", :force => true do |t|
    t.string   "var",                       :null => false
    t.text     "value"
    t.integer  "target_id"
    t.string   "target_type", :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["target_type", "target_id", "var"], :name => "index_settings_on_target_type_and_target_id_and_var", :unique => true

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "follows_count"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
