class CreatePromotableTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :promotable_tweets do |t|
      t.string :tweet_id
      t.datetime :c_time
      t.datetime :u_time
      t.boolean :deleted
      t.string :ptweet_id
      t.boolean :paused
      t.string :approval_status
      t.string :line_id
      t.string :acc_id
      t.belongs_to :account, index: true
      
      t.timestamps
    end
  end
end
