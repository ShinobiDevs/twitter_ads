class CreateAppEventTags < ActiveRecord::Migration[5.0]
  def change
    create_table :app_event_tags do |t|
      t.string :app_tag_id
      t.string :app_store_identifier
      t.string :os_type
      t.string :conversion_type
      t.string :provider_app_event_id
      t.string :provider_app_event_name
      t.integer :post_engagement_attribution_window
      t.integer :post_view_attribution_window
      t.datetime :c_time
      t.datetime :u_time
      t.boolean :deleted
      t.boolean :retargeting_enabled
      t.belongs_to :account, index: true

      t.timestamps
    end
  end
end
