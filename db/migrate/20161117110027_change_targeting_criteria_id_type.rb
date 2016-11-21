class ChangeTargetingCriteriaIdType < ActiveRecord::Migration[5.0]
  def change
    # add_column :targeting_criteria, :account_id, :integer
    # add_column :targeting_criteria, :line_item_id, :integer
    add_column :targeting_criteria, :acc_id, :string
    add_column :targeting_criteria, :line_id, :string 
  end
end
