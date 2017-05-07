class CreateTripTables < ActiveRecord::Migration[5.0]
  def change

    create_table :bikes do |t|
      t.integer  :bike

      t.timestamps null: false
    end

    create_table :subscription_types do |t|
      t.text     :sub_type

      t.timestamps null: false
    end

    create_table :zipcodes do |t|
      t.integer  :zipcode

      t.timestamps null: false
    end

    create_table :trips do |t|
      t.integer :duration
      t.integer :date_ref_id
      t.integer :end_date_id
      t.integer  :start_station_id
      t.integer  :end_station_id
      t.integer  :bike_id
      t.integer :subscription_type_id
      t.integer :zipcode_id

      t.timestamps null: false
    end
  end
end
