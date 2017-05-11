class DropCityColumnWeather < ActiveRecord::Migration[5.0]
  def change
    remove_column :weather_statistics, :city_id
  end
end
