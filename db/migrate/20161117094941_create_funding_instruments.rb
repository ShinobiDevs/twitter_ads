class CreateFundingInstruments < ActiveRecord::Migration[5.0]
  def change
    create_table :funding_instruments do |t|
      t.string :funding_id
      t.string :name
      t.boolean :cancelled
      t.bigint :credit_limit_local_micro
      t.string :currency
      t.string :description
      t.bigint :funded_amount_local_micro
      t.string :f_type
      t.boolean :deleted
      t.belongs_to :account, index: true
      t.boolean :able_to_fund
      t.datetime :end_time
      t.datetime :c_time
      t.datetime :u_time
      t.string :io_header
      t.text :reasons_not_able_to_fund
      t.boolean :paused

      t.timestamps
    end
  end
end
