require 'twitter-ads'
require 'json'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :initialize_client

  def fetch_data
  	@accounts = @client.accounts
  	@account = @accounts.first
  	api_calls
  end

  def account
  	begin
	  	@account = @client.accounts(params[:id])
	  	api_calls
	rescue Exception => @ex
		@account = @ex
		# puts @ex
	end 
  	render :partial => 'group_fields', layout: false	
  end

  private

  # initialize the client
  def initialize_client
  	@client = TwitterAds::Client.new(
	  ENV['CONSUMER_KEY'],
	  ENV['CONSUMER_SECRET'],
	  ENV['ACCESS_TOKEN'],
	  ENV['ACCESS_TOKEN_SECRET']
	)
  end

  def api_calls
  	# puts @account

  	@data = {}
  	# To get app names and app ids, 'GET accounts/:account_id/app_lists'
  	resource = "/1/accounts/#{@account.id}/app_lists"
	params = {}

	begin
		response = TwitterAds::Request.new(@client, :get, resource, params: params).perform
		@data['app_names_ids'] = response.body
	rescue Exception => @ex
		# puts @ex
		@data['app_names_ids'] = @ex
	end	

	# To get platform, 'GET accounts/:account_id/app_event_tags'
  	resource = "/1/accounts/#{@account.id}/app_event_tags"
	params = {}

	begin
		response = TwitterAds::Request.new(@client, :get, resource, params: params).perform
		@data['app_platform_retargetting'] = response.body.to_json
	rescue Exception => @ex
		# puts @ex
		@data['app_platform_retargetting'] = @ex
	end

	# To get campaign information, 'GET accounts/:account_id/campaigns'
	begin
  		@data['campaign'] = @account.campaigns
	rescue Exception => @ex
		# puts @ex
		@data['campaign'] = @ex
	end

	# To get Countries, 'GET targeting_criteria/locations'
	resource = '/1/targeting_criteria/locations'
	params   = { location_type: 'COUNTRY'}
	request  = TwitterAds::Request.new(@client, :get, resource, params: params)
	@cursor   = TwitterAds::Cursor.new(nil, request)



	# To get Metrics
	# limit request count and grab the first 10 line items from TwitterAds::Cursor
	begin
		line_items = @account.line_items[0..9]
		# metric_groups = ['ENGAGEMENT','BILLING']
		metric_groups = ['ENGAGEMENT', 'BILLING', 'WEB_CONVERSION', 'MOBILE_CONVERSION']

		# fetching stats for multiple line items
		ids = line_items.map(&:id)
		# puts line_items.count
		# puts ids
		opts = {start_time: Time.parse('2016-07-22T00:00:00Z'), end_time: Time.parse('2016-07-28T00:00:00Z'),granularity: 'TOTAL'}
		# @metrics = line_items.first.stats(metric_groups)
		
		@metrics = TwitterAds::LineItem.stats(@account, ids, metric_groups, opts)	
	rescue Exception => @ex
		@metrics = @ex
	end
	
	# begin
	# 	@account.videos.each do |video|
	# 		puts video.to_json
	# 	end
	# rescue Exception => e
	# 	puts e
	# end
	begin
		@account.promotable_tweets.each do |pa|
			puts pa.to_json
		end
	rescue Exception => e
		puts e
	end

  end
end
