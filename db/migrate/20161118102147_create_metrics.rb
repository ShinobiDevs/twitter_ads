class CreateMetrics < ActiveRecord::Migration[5.0]
  def change
    create_table :metrics do |t|
      t.string :line_id
      t.text :impressions
      t.text :clicks
      t.text :billed_charge_local_micro
      t.datetime :track_start_time
      t.datetime :track_end_time
      t.string :granularity
      t.string :acc_id

      t.timestamps
    end
  end
end
