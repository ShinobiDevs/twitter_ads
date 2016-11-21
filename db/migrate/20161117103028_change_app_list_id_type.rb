class ChangeAppListIdType < ActiveRecord::Migration[5.0]
  def change
    # add_column :app_lists, :account_id, :integer
    add_column :app_lists, :acc_id, :string
  end

end
