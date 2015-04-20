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

ActiveRecord::Schema.define(version: 20150420014902) do

  create_table "articles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "league_time_periods", force: true do |t|
    t.integer  "league_id"
    t.integer  "time_period_id"
    t.float    "scoring_weight", default: 1.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lineup_articles", force: true do |t|
    t.integer  "lineup_id"
    t.integer  "article_id"
    t.integer  "last_year_views"
    t.integer  "views"
    t.integer  "days_passed"
    t.float    "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lineups", force: true do |t|
    t.integer  "time_period_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.string   "owner_id"
    t.integer  "league_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_periods", force: true do |t|
    t.string   "name"
    t.string   "duration"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     default: false
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
