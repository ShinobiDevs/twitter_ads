class ChangeFundingInstrumentIdType < ActiveRecord::Migration[5.0]
  def change
    # add_column :funding_instruments, :account_id, :integer
    add_column :funding_instruments, :acc_id, :string  
  end
end
