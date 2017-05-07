class DropAndReset < ActiveRecord::Migration[5.0]
  def change
    drop_table :stations
    drop_table :cities
    
    create_table :stations do |t|
      t.text    :name
      t.integer :dock_count
      t.integer :the_date_id
      t.integer :city_id
      t.float   :lat
      t.float   :long

      t.timestamps null: false
    end

    create_table :cities do |t|
      t.text    :name

      t.timestamps null: false
    end

    create_table :the_dates do |t|
      t.date    :date
      t.text    :name

      t.timestamps null: false
    end

  end
end
