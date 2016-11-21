class CreateWebEventTags < ActiveRecord::Migration[5.0]
  def change
    create_table :web_event_tags do |t|
      t.string :web_tag_id
      t.string :name
      t.integer :click_window
      t.text :embed_code
      t.boolean :retargeting_enabled
      t.string :status
      t.string :w_type
      t.integer :view_through_window
      t.boolean :deleted
      t.belongs_to :account, index: true
      
      t.timestamps
    end
  end
end
