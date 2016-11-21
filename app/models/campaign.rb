class Campaign < ApplicationRecord
	# self.record_timestamps = false
	belongs_to :account
	belongs_to :funding_instrument
	has_many :line_items, dependent: :destroy
end
