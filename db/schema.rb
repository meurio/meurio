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

ActiveRecord::Schema.define(version: 20131016204613) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "image"
    t.index ["email"], :name => "index_users_on_email", :unique => true, :order => {"email" => :asc}
    t.index ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true, :order => {"reset_password_token" => :asc}
  end

  create_table "campaigns", force: true do |t|
    t.string   "name"
    t.string   "link"
    t.text     "description_html"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.string   "hashtag"
    t.integer  "user_id"
    t.string   "user_email"
    t.index ["user_id"], :name => "fk__campaigns_user_id", :order => {"user_id" => :asc}
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_campaigns_user_id"
  end

  create_table "pokes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "campaign_id"
    t.string   "uid"
    t.integer  "user_id"
    t.string   "user_email"
    t.index ["campaign_id"], :name => "fk__pokes_campaign_id", :order => {"campaign_id" => :asc}
    t.index ["user_id"], :name => "fk__pokes_user_id", :order => {"user_id" => :asc}
    t.foreign_key ["campaign_id"], "campaigns", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_pokes_campaign_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_pokes_user_id"
  end

  create_view "activities", "SELECT c.id, c.user_id, c.created_at, c.hashtag, 'campaigns'::text AS relname FROM campaigns c UNION ALL SELECT p.id, p.user_id, p.created_at, pc.hashtag, 'pokes'::text AS relname FROM (pokes p JOIN campaigns pc ON ((pc.id = p.campaign_id)))", :force => true
  create_table "clippings", force: true do |t|
    t.datetime "published_at"
    t.text     "body"
    t.string   "link"
    t.string   "image"
    t.string   "hashtag"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facebook_posts", force: true do |t|
    t.text     "text"
    t.string   "hashtag"
    t.string   "username"
    t.datetime "published_at"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "text_html"
    t.string   "user_uid"
    t.integer  "share_count"
    t.integer  "like_count"
  end

  create_table "tweets", force: true do |t|
    t.text     "text"
    t.string   "hashtag"
    t.string   "username"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.text     "text_html"
    t.string   "user_uid"
    t.integer  "retweet_count"
    t.integer  "favorite_count"
  end

  create_view "comments", "SELECT t.id, t.created_at, t.text, t.hashtag, t.username, t.published_at, t.text_html, t.user_uid, t.retweet_count AS share_count, t.favorite_count AS like_count, 'tweets'::text AS relname FROM tweets t UNION ALL SELECT fp.id, fp.created_at, fp.text, fp.hashtag, fp.username, fp.published_at, fp.text_html, fp.user_uid, fp.share_count, fp.like_count, 'facebook_posts'::text AS relname FROM facebook_posts fp", :force => true
  create_table "events", force: true do |t|
    t.string   "hashtag"
    t.integer  "attending_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.string   "name"
    t.text     "description"
    t.string   "link"
  end

  create_table "problems", force: true do |t|
    t.string   "name"
    t.string   "link"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.string   "hashtag"
  end

  create_view "facts", "(SELECT c.id, c.created_at, c.name, c.description_html, c.link, c.hashtag, 'campaigns'::text AS relname FROM campaigns c UNION ALL SELECT p.id, p.created_at, p.name, p.description AS description_html, p.link, p.hashtag, 'problems'::text AS relname FROM problems p) UNION ALL SELECT e.id, e.created_at, e.name, e.description AS description_html, e.link, e.hashtag, 'events'::text AS relname FROM events e", :force => true
  create_table "ideas", force: true do |t|
    t.string   "name"
    t.string   "link"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "problem_id"
    t.string   "uid"
    t.index ["problem_id"], :name => "index_ideas_on_problem_id", :order => {"problem_id" => :asc}
    t.foreign_key ["problem_id"], "problems", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_ideas_problem_id"
  end

  create_table "images", force: true do |t|
    t.string   "file"
    t.string   "hashtag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
  end

  create_table "mobilizations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.string   "hashtag"
    t.string   "short_title"
  end

end
