class UpdateWeatherStatColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :weather_statistics, :zipcode_id, :city_id
  end
end
