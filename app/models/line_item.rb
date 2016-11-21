class LineItem < ApplicationRecord
	serialize :placements

	belongs_to :account
	belongs_to :campaign
	has_many :targeting_criteria, dependent: :destroy
end
