class CreatePromotableUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :promotable_users do |t|
      t.string :acc_id
      t.datetime :c_time
      t.datetime :u_time
      t.boolean :deleted
      t.string :puser_id
      t.string :promotable_user_type
      t.string :user_id
      t.belongs_to :account, index: true
      
      t.timestamps
    end
  end
end
