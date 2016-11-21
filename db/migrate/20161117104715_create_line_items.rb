class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|
      t.string :line_id
      t.string :bid_type
      t.bigint :advertiser_user_id
      t.string :name
      t.text :placements
      t.datetime :start_time
      t.bigint :bid_amount_local_micro
      t.boolean :automatically_select_bid
      t.string :advertiser_domain
      t.bigint :target_cpa_local_micro
      t.string :primary_web_event_tag
      t.string :charge_by
      t.string :product_type
      t.datetime :end_time
      t.string :bid_unit
      t.bigint :total_budget_amount_local_micro
      t.string :objective
      t.string :entity_status
      t.boolean :paused
      t.string :optimization
      t.text :categories
      t.string :currency
      t.text :tracking_tags
      t.string :include_sentiment
      t.string :creative_source
      t.boolean :deleted
      t.belongs_to :account, index: true
      t.belongs_to :campaign, index: true
      t.datetime :c_time
      t.datetime :u_time
      
      t.timestamps
    end
  end
end
