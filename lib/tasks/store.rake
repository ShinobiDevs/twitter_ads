require 'twitter-ads'
require 'json'

desc "Store Twitter Ads data into DB"
task store: :environment do
	client = initialize_client
	accounts = client.accounts

	# Store accounts
	accounts.each do |account|
		db_acc = Account.create(acc_id: account.id, name: account.name, salt: account.salt, timezone: account.timezone, timezone_switch_at: account.timezone_switch_at, deleted: account.deleted, c_time: account.created_at, u_time: account.updated_at)

		
		begin
			# Store funding_instruments
			resource = "/1/accounts/#{account.id}/funding_instruments"
			params   = {}
			response = TwitterAds::Request.new(client, :get, resource, params: params).perform
			response = response.body
			if response[:total_count] > 0
				funds = response[:data]
				
				funds.each do |f|
					db_acc.funding_instruments.create!(funding_id: f[:id], description: f[:description], credit_limit_local_micro: f[:credit_limit_local_micro], end_time: f[:end_time], cancelled: f[:cancelled], paused: f[:paused], currency: f[:currency], funded_amount_local_micro: f[:funded_amount_local_micro], c_time: f[:created_at], u_time: f[:updated_at], f_type: f[:type], deleted: f[:deleted], able_to_fund: f[:able_to_fund], io_header: f[:io_header], reasons_not_able_to_fund: f[:reasons_not_able_to_fund])
				end
				
			end

			# Store campaigns
			account.campaigns.each do |camp|
				db_fund = FundingInstrument.find_by(funding_id: camp.funding_instrument_id)
				db_acc.campaigns.create!(camp_id: camp.id, name: camp.name, start_time: camp.start_time, servable: camp.servable, daily_budget_amount_local_micro: camp.daily_budget_amount_local_micro, end_time: camp.end_time, standard_delivery: camp.standard_delivery, total_budget_amount_local_micro: camp.total_budget_amount_local_micro, paused: camp.paused, currency: camp.currency, deleted: camp.deleted, funding_instrument_id: db_fund.id, funding_id: camp.funding_instrument_id, acc_id: account.id, c_time: camp.created_at, u_time: camp.updated_at)
			end

			# Store app_lists
			resource = "/1/accounts/#{account.id}/app_lists"
			params = {}
			
			response = TwitterAds::Request.new(client, :get, resource, params: params).perform
			response = response.body

			app_lists = response[:data]
			app_lists.each do |app|
				db_acc.app_lists.create!(a_list_id: app.id, name: app.name)
			end

			# Store app_event_tags
			resource = "/1/accounts/#{account.id}/app_event_tags"
			params = {}

			response = TwitterAds::Request.new(client, :get, resource, params: params).perform
			response = response.body

			app_event_tags = response[:data]
			app_event_tags.each do |app|
				db_acc.app_event_tags.create!(app_tag_id: app[:id], app_store_identifier: app[:app_store_identifier], os_type: app[:os_type], conversion_type: app[:conversion_type], provider_app_event_id: app[:provider_app_event_id], provider_app_event_name: app[:provider_app_event_name], post_engagement_attribution_window: app[:post_engagement_attribution_window], post_view_attribution_window: app[:post_view_attribution_window], c_time: app[:created_at], u_time: app[:updated_at], deleted: app[:deleted], retargeting_enabled: app[:retargeting_enabled])
			end

			# Store web_event_tags
			resource = "/1/accounts/#{account.id}/web_event_tags"
			params = {}

			response = TwitterAds::Request.new(client, :get, resource, params: params).perform
			response = response.body

			web_event_tags = response[:data]
			web_event_tags.each do |web|
				db_acc.web_event_tags.create!(web_tag_id: web[:id], name: web[:name], click_window: web[:click_window], embed_code: web[:embed_code], retargeting_enabled: web[:retargeting_enabled], status: web[:status], w_type: web[:type], view_through_window: web[:view_through_window], deleted: web[:deleted])
			end

			# Store line_items
			line_items = account.line_items
			line_items.each do |line|
				db_camp = db_acc.campaigns.find_by(camp_id: line.campaign_id)
				
				db_acc.line_items.create!(line_id: line.id, bid_type: line.bid_type, advertiser_user_id: line.advertiser_user_id, name: line.name, placements: line.placements, bid_amount_local_micro: line.bid_amount_local_micro, automatically_select_bid: line.automatically_select_bid, advertiser_domain: line.advertiser_domain, primary_web_event_tag: line.primary_web_event_tag, charge_by: line.charge_by, product_type: line.product_type, bid_unit: line.bid_unit, total_budget_amount_local_micro: line.total_budget_amount_local_micro, objective: line.objective, paused: line.paused, optimization: line.optimization, include_sentiment: line.include_sentiment, deleted: line.deleted, acc_id: line.account, camp_id: line.campaign_id, c_time: line.created_at, u_time: line.updated_at, campaign_id: db_camp.id)
			end

			# Store Metrics
			# Fetch 10 line_items for each account
			line_items = account.line_items[0..9]
			# metric_groups = ['ENGAGEMENT','BILLING']
			metric_groups = ['ENGAGEMENT', 'BILLING', 'WEB_CONVERSION', 'MOBILE_CONVERSION']
			start_time = Time.parse('2016-07-22T00:00:00Z')
			end_time   = Time.parse('2016-07-28T00:00:00Z')
			granularity = 'TOTAL'
			# fetching stats for multiple line items
			ids = line_items.map(&:id)
			opts = {start_time: start_time, end_time: end_time,granularity: granularity}
			# metrics = line_items.first.stats(metric_groups)
			
			metrics = TwitterAds::LineItem.stats(account, ids, metric_groups, opts)

			metrics.each do |m|
				Metric.create!(line_id: m[:id], impressions: m[:id_data][0][:metrics][:impressions], clicks: m[:id_data][0][:metrics][:clicks], billed_charge_local_micro: m[:id_data][0][:metrics][:billed_charge_local_micro], track_start_time: start_time, track_end_time: end_time, granularity: granularity, acc_id: account.id)
			end


			# Store Video(Creative)
			account.videos.each do |video|
				db_acc.videos.create!(tweeted: video.tweeted, ready_to_tweet: video.ready_to_tweet, duration: video.duration, description: video.description, preview_url: video.preview_url, v_id: video.id, c_time: video.created_at, u_time: video.updated_at, title: video.title, deleted: video.deleted, acc_id: account.id)
			end

			# Store PromotableTweet(Creative)
			account.promotable_tweets.each do |pt|
				db_acc.promotable_tweets.create!(tweet_id: pt.tweet_id, c_time: pt.created_at, u_time: pt.updated_at, deleted: pt.deleted, ptweet_id: pt.id, paused: pt.paused, approval_status: pt.approval_status, line_id: pt.line_item_id, acc_id: account.id)
			end

			# Store PromotableUsers(Creative)
			account.promotable_users.each do |pu|
				db_acc.promotable_users.create!(acc_id: account.id, c_time: pu.created_at, u_time: pu.updated_at, deleted: pu.deleted, puser_id: pu.id, promotable_user_type: pu.promotable_user_type, user_id: pu.user_id)
			end

		rescue Exception => @ex
			puts @ex
		end
	end

	# Store locations
	resource = '/1/targeting_criteria/locations'
	params   = { location_type: 'COUNTRY'}
	response = TwitterAds::Request.new(client, :get, resource, params: params).perform
	response = response.body
	locations = response[:data]
	locations.each do |loc|
		Location.create!(name: loc[:name], country_code: loc[:country_code], location_type: loc[:location_type], targeting_value: loc[:targeting_value], targeting_type: loc[:targeting_type])
	end
end

# initialize the client
def initialize_client
	TwitterAds::Client.new(
	  ENV['CONSUMER_KEY'],
	  ENV['CONSUMER_SECRET'],
	  ENV['ACCESS_TOKEN'],
	  ENV['ACCESS_TOKEN_SECRET']
	)
end