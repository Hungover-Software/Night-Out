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

ActiveRecord::Schema.define(version: 20170801232901) do

  create_table "comments", force: :cascade do |t|
    t.string "message"
    t.datetime "timestamp"
    t.integer "user_id"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_comments_on_event_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "event_invites", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_event_invites_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.date "date"
    t.time "time"
    t.integer "event_invite_id"
    t.integer "comment_id"
    t.integer "poll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_events_on_comment_id"
    t.index ["event_invite_id"], name: "index_events_on_event_invite_id"
    t.index ["poll_id"], name: "index_events_on_poll_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "friends", force: :cascade do |t|
    t.integer "user_sender_id", null: false
    t.integer "user_receiver_id", null: false
    t.boolean "accepted", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.integer "users"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.integer "vote_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_options_on_user_id"
    t.index ["vote_id"], name: "index_options_on_vote_id"
  end

  create_table "polls", force: :cascade do |t|
    t.string "name"
    t.integer "option_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_id"], name: "index_polls_on_option_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "preferred_name"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

end
