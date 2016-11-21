class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :acc_id
      t.string :name
      t.string :salt
      t.string :timezone
      t.datetime :timezone_switch_at
      t.boolean :deleted
      t.datetime :c_time
      t.datetime :u_time

      t.timestamps
    end
  end
end
