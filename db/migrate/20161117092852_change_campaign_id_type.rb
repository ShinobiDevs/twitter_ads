class ChangeCampaignIdType < ActiveRecord::Migration[5.0]
  def change
  	
    # add_column :campaigns, :account_id, :integer
    # add_column :campaigns, :funding_instrument_id, :integer
    add_column :campaigns, :acc_id, :string
    add_column :campaigns, :funding_id, :string 
  end
end
