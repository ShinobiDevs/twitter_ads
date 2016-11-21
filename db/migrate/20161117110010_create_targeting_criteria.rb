class CreateTargetingCriteria < ActiveRecord::Migration[5.0]
  def change
    create_table :targeting_criteria do |t|
      t.string :t_criteria_id
      t.string :name
      t.string :localized_name
      t.boolean :deleted
      t.string :targeting_type
      t.string :targeting_value
      t.boolean :tailored_audience_expansion
      t.string :tailored_audience_type
      t.string :location_type
      t.belongs_to :account, index: true
      t.belongs_to :line_item, index: true
      t.datetime :c_time
      t.datetime :u_time
      
      t.timestamps
    end
  end
end
