require './app/models/station'
require './app/models/city'
require './app/models/date_ref'
require './app/models/bike'
require './app/models/trip'
require './app/models/zipcode'
require './app/models/subscription_type'
require './app/models/weather_statistic'
require 'csv'
require "pry"

Station.destroy_all
City.destroy_all
DateRef.destroy_all
Bike.destroy_all
Trip.destroy_all
SubscriptionType.destroy_all
Zipcode.destroy_all
WeatherStatistic.destroy_all

stations = CSV.open './db/csv/station.csv', headers:true, header_converters: :symbol
stations.each do |row|
  date = row[:installation_date]
  date = DateRef.clean_date(date)
  date = DateRef.find_or_create_by!(date: date)
  city = City.find_or_create_by!(name: row[:city])
  Station.create!(name: row[:name], dock_count: row[:dock_count], lat: row[:lat], long: row[:long], date_ref_id: date.id, city_id: city.id)
end


trips = CSV.open './db/csv/trip.csv', headers:true, header_converters: :symbol
trips.each do |row|
  start_date = row[:start_date]
  start_date = DateRef.clean_date(start_date)
  start_date = DateRef.find_or_create_by!(date: start_date)

  end_date = row[:end_date]
  end_date = DateRef.clean_date(end_date)
  end_date = DateRef.find_or_create_by!(date: end_date)

  bike = Bike.find_or_create_by!(bike: row[:bike_id])

  zipcode =
    if  row[:zip_code].nil?
      Zipcode.find_or_create_by!(zipcode: "n/a")
    else
      Zipcode.find_or_create_by!(zipcode: (row[:zip_code][0..4]))
    end

  subscription = SubscriptionType.find_or_create_by!(sub_type: row[:subscription_type])

  start_station = Station.validate_name_change(row[:start_station_name])
  start_station = Station.find_by(name: start_station)

  end_station = Station.validate_name_change(row[:end_station_name])
  end_station = Station.find_by(name: end_station)
  # binding.pry

  Trip.create!(
              duration: row[:duration],
              date_ref_id: start_date.id,
              end_date_id: end_date.id,
              start_station_id: start_station.id,
              end_station_id: end_station.id,
              bike_id: bike.id,
              zipcode_id: zipcode.id,
              subscription_type_id: subscription.id)
end

weather_statistics = CSV.open './db/csv/weather.csv', headers:true, header_converters: :symbol
weather_statistics.each do |row|
  # binding.pry
  if row[:zip_code] == '94107'
  date = row[:date]
  date = DateRef.clean_date(date)
  date = DateRef.find_or_create_by!(date: date)
  city = City.find_by(name: city)

  WeatherStatistic.create!(
    date_ref_id: date.id,
    max_temperature: row[:max_temperature_f],
    mean_temperature: row[:mean_temperature_f],
    min_temperature: row[:mean_temperature_f],
    mean_humidity: row[:mean_humidity],
    mean_visibility: row[:mean_visibility_miles],
    mean_wind_speed: row[:mean_wind_speed_mph],
    precipitation: row[:precipitation_inches],
  )
  else
    next
  end
end



