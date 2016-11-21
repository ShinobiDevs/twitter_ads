class FundingInstrument < ApplicationRecord
	serialize :reasons_not_able_to_fund
	
	belongs_to :account
	has_many :campaigns
end
