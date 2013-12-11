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

ActiveRecord::Schema.define(version: 20131211074102) do

  create_table "fragments", force: true do |t|
    t.string   "home_mainbar_bottom"
    t.string   "home_sidebar_bottom"
    t.string   "topics_sidebar_bottom"
    t.string   "footer"
    t.integer  "site_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "replies", force: true do |t|
    t.integer  "author_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "content"
  end

  create_table "sites", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "index_value", default: 0
  end

  create_table "topic_marked_users", force: true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topic_marked_users", ["topic_id"], name: "index_topic_marked_users_on_topic_id"
  add_index "topic_marked_users", ["user_id"], name: "index_topic_marked_users_on_user_id"

  create_table "topic_readed_users", force: true do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topic_readed_users", ["topic_id"], name: "index_topic_readed_users_on_topic_id"
  add_index "topic_readed_users", ["user_id"], name: "index_topic_readed_users_on_user_id"

  create_table "topic_tags", force: true do |t|
    t.integer  "topic_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "actived_at"
    t.datetime "edited_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "access_token"
    t.string   "locale",          default: "zh-CN"
  end

end
