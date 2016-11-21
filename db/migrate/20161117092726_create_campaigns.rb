class CreateCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.string :camp_id
      t.string :name
      t.datetime :start_time
      t.boolean :servable
      t.bigint :daily_budget_amount_local_micro
      t.datetime :end_time
      t.boolean :standard_delivery
      t.bigint :total_budget_amount_local_micro
      t.string :entity_status
      t.boolean :paused
      t.string :currency
      t.boolean :deleted
      t.integer :duration_in_days
      t.belongs_to :account, index: true
      t.belongs_to :funding_instrument, index: true
      t.datetime :c_time
      t.datetime :u_time
      
      t.timestamps
    end
  end
end
