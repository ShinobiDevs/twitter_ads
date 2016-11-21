class ChangeLineItemIdType < ActiveRecord::Migration[5.0]
  def change
    # add_column :line_items, :account_id, :integer
    # add_column :line_items, :campaign_id, :integer
    add_column :line_items, :acc_id, :string
    add_column :line_items, :camp_id, :string 
  end

end
