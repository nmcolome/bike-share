class WeatherTable < ActiveRecord::Migration[5.0]
  def change
    create_table :weather_statistics do |t|
      t.integer    :date_ref_id
      t.float      :max_temperature
      t.float      :mean_temperature
      t.float      :min_temperature
      t.float      :mean_humidity
      t.float      :mean_visibility
      t.float      :mean_wind_speed
      t.float      :precipitation
      t.integer    :zipcode_id

      t.timestamps  null: false
    end
    
  end
end
