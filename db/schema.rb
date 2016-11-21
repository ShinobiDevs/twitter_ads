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

ActiveRecord::Schema.define(version: 20161118123408) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "acc_id"
    t.string   "name"
    t.string   "salt"
    t.string   "timezone"
    t.datetime "timezone_switch_at"
    t.boolean  "deleted"
    t.datetime "c_time"
    t.datetime "u_time"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "app_event_tags", force: :cascade do |t|
    t.string   "app_tag_id"
    t.string   "app_store_identifier"
    t.string   "os_type"
    t.string   "conversion_type"
    t.string   "provider_app_event_id"
    t.string   "provider_app_event_name"
    t.integer  "post_engagement_attribution_window"
    t.integer  "post_view_attribution_window"
    t.datetime "c_time"
    t.datetime "u_time"
    t.boolean  "deleted"
    t.boolean  "retargeting_enabled"
    t.integer  "account_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["account_id"], name: "index_app_event_tags_on_account_id", using: :btree
  end

  create_table "app_lists", force: :cascade do |t|
    t.string   "a_list_id"
    t.string   "name"
    t.integer  "account_id"
    t.datetime "c_time"
    t.datetime "u_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "acc_id"
    t.index ["account_id"], name: "index_app_lists_on_account_id", using: :btree
  end

  create_table "campaigns", force: :cascade do |t|
    t.string   "camp_id"
    t.string   "name"
    t.datetime "start_time"
    t.boolean  "servable"
    t.bigint   "daily_budget_amount_local_micro"
    t.datetime "end_time"
    t.boolean  "standard_delivery"
    t.bigint   "total_budget_amount_local_micro"
    t.string   "entity_status"
    t.boolean  "paused"
    t.string   "currency"
    t.boolean  "deleted"
    t.integer  "duration_in_days"
    t.integer  "account_id"
    t.integer  "funding_instrument_id"
    t.datetime "c_time"
    t.datetime "u_time"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "acc_id"
    t.string   "funding_id"
    t.index ["account_id"], name: "index_campaigns_on_account_id", using: :btree
    t.index ["funding_instrument_id"], name: "index_campaigns_on_funding_instrument_id", using: :btree
  end

  create_table "funding_instruments", force: :cascade do |t|
    t.string   "funding_id"
    t.string   "name"
    t.boolean  "cancelled"
    t.bigint   "credit_limit_local_micro"
    t.string   "currency"
    t.string   "description"
    t.bigint   "funded_amount_local_micro"
    t.string   "f_type"
    t.boolean  "deleted"
    t.integer  "account_id"
    t.boolean  "able_to_fund"
    t.datetime "end_time"
    t.datetime "c_time"
    t.datetime "u_time"
    t.string   "io_header"
    t.text     "reasons_not_able_to_fund"
    t.boolean  "paused"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "acc_id"
    t.index ["account_id"], name: "index_funding_instruments_on_account_id", using: :btree
  end

  create_table "line_items", force: :cascade do |t|
    t.string   "line_id"
    t.string   "bid_type"
    t.bigint   "advertiser_user_id"
    t.string   "name"
    t.text     "placements"
    t.datetime "start_time"
    t.bigint   "bid_amount_local_micro"
    t.boolean  "automatically_select_bid"
    t.string   "advertiser_domain"
    t.bigint   "target_cpa_local_micro"
    t.string   "primary_web_event_tag"
    t.string   "charge_by"
    t.string   "product_type"
    t.datetime "end_time"
    t.string   "bid_unit"
    t.bigint   "total_budget_amount_local_micro"
    t.string   "objective"
    t.string   "entity_status"
    t.boolean  "paused"
    t.string   "optimization"
    t.text     "categories"
    t.string   "currency"
    t.text     "tracking_tags"
    t.string   "include_sentiment"
    t.string   "creative_source"
    t.boolean  "deleted"
    t.integer  "account_id"
    t.integer  "campaign_id"
    t.datetime "c_time"
    t.datetime "u_time"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "acc_id"
    t.string   "camp_id"
    t.index ["account_id"], name: "index_line_items_on_account_id", using: :btree
    t.index ["campaign_id"], name: "index_line_items_on_campaign_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "country_code"
    t.string   "location_type"
    t.string   "targeting_value"
    t.string   "targeting_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "metrics", force: :cascade do |t|
    t.string   "line_id"
    t.text     "impressions"
    t.text     "clicks"
    t.text     "billed_charge_local_micro"
    t.datetime "track_start_time"
    t.datetime "track_end_time"
    t.string   "granularity"
    t.string   "acc_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "promotable_tweets", force: :cascade do |t|
    t.string   "tweet_id"
    t.datetime "c_time"
    t.datetime "u_time"
    t.boolean  "deleted"
    t.string   "ptweet_id"
    t.boolean  "paused"
    t.string   "approval_status"
    t.string   "line_id"
    t.string   "acc_id"
    t.integer  "account_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["account_id"], name: "index_promotable_tweets_on_account_id", using: :btree
  end

  create_table "promotable_users", force: :cascade do |t|
    t.string   "acc_id"
    t.datetime "c_time"
    t.datetime "u_time"
    t.boolean  "deleted"
    t.string   "puser_id"
    t.string   "promotable_user_type"
    t.string   "user_id"
    t.integer  "account_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["account_id"], name: "index_promotable_users_on_account_id", using: :btree
  end

  create_table "targeting_criteria", force: :cascade do |t|
    t.string   "t_criteria_id"
    t.string   "name"
    t.string   "localized_name"
    t.boolean  "deleted"
    t.string   "targeting_type"
    t.string   "targeting_value"
    t.boolean  "tailored_audience_expansion"
    t.string   "tailored_audience_type"
    t.string   "location_type"
    t.integer  "account_id"
    t.integer  "line_item_id"
    t.datetime "c_time"
    t.datetime "u_time"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "acc_id"
    t.string   "line_id"
    t.index ["account_id"], name: "index_targeting_criteria_on_account_id", using: :btree
    t.index ["line_item_id"], name: "index_targeting_criteria_on_line_item_id", using: :btree
  end

  create_table "videos", force: :cascade do |t|
    t.boolean  "tweeted"
    t.boolean  "ready_to_tweet"
    t.integer  "duration"
    t.text     "description"
    t.string   "preview_url"
    t.string   "v_id"
    t.datetime "c_time"
    t.datetime "u_time"
    t.string   "title"
    t.string   "deleted"
    t.string   "acc_id"
    t.integer  "account_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["account_id"], name: "index_videos_on_account_id", using: :btree
  end

  create_table "web_event_tags", force: :cascade do |t|
    t.string   "web_tag_id"
    t.string   "name"
    t.integer  "click_window"
    t.text     "embed_code"
    t.boolean  "retargeting_enabled"
    t.string   "status"
    t.string   "w_type"
    t.integer  "view_through_window"
    t.boolean  "deleted"
    t.integer  "account_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["account_id"], name: "index_web_event_tags_on_account_id", using: :btree
  end

end
