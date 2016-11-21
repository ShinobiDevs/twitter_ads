class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :country_code
      t.string :location_type
      t.string :targeting_value
      t.string :targeting_type

      t.timestamps
    end
  end
end
