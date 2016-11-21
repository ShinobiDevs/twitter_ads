class CreateAppLists < ActiveRecord::Migration[5.0]
  def change
    create_table :app_lists do |t|
      t.string :a_list_id
      t.string :name
      t.belongs_to :account, index: true
      t.datetime :c_time
      t.datetime :u_time

      t.timestamps
    end
  end
end
