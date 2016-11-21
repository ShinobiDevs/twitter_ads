class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.boolean :tweeted
      t.boolean :ready_to_tweet
      t.integer :duration
      t.text :description
      t.string :preview_url
      t.string :v_id
      t.datetime :c_time
      t.datetime :u_time
      t.string :title
      t.string :deleted
      t.string :acc_id
      t.belongs_to :account, index: true
      
      t.timestamps
    end
  end
end
