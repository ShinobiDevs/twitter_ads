class TargetingCriterium < ApplicationRecord
	belongs_to :account
	belongs_to :line_item
end
