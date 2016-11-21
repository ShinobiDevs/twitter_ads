class Account < ApplicationRecord
	has_many :campaigns, dependent: :destroy
	has_many :funding_instruments, dependent: :destroy
	has_many :app_lists, dependent: :destroy
	has_many :line_items, dependent: :destroy
	has_many :targeting_criteria, dependent: :destroy
	has_many :app_event_tags, dependent: :destroy
	has_many :web_event_tags, dependent: :destroy
	has_many :videos, dependent: :destroy
	has_many :promotable_tweets, dependent: :destroy
	has_many :promotable_users, dependent: :destroy
end
