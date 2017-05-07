require './app/models/station'
require './app/models/city'
require './app/models/date_ref'
require './app/models/bike'
require './app/models/trip'
require './app/models/zipcode'
require './app/models/subscription_type'
require 'csv'
require "pry"

Station.destroy_all
City.destroy_all
DateRef.destroy_all
Bike.destroy_all
Trip.destroy_all
SubscriptionType.destroy_all
Zipcode.destroy_all

stations = CSV.open './db/csv/station.csv', headers:true, header_converters: :symbol
stations.each do |row|
  date = row[:installation_date]
  date = DateRef.clean_date(date)
  date = DateRef.find_or_create_by!(date: date)
  city = City.find_or_create_by!(name: row[:city])
  Station.create!(name: row[:name], dock_count: row[:dock_count], lat: row[:lat], long: row[:long], date_ref_id: date.id, city_id: city.id)
end


trips = CSV.open './db/csv/trip_fixture.csv', headers:true, header_converters: :symbol
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
      nil
    else
      Zipcode.find_or_create_by!(zipcode: (row[:zip_code][0..4]))
    end

  subscription = SubscriptionType.find_or_create_by!(sub_type: row[:subscription_type])

  start_station = Station.validate_name_change(row[:start_station_name])
  start_station = Station.find_by(name: start_station)

  end_station = Station.validate_name_change(row[:end_station_name])

  end_station = Station.find_by(name: end_station)

  Trip.create!(date_ref_id: start_date.id,
              end_date_id: end_date.id,
              start_station_id: start_station.id,
              end_station_id: end_station.id,
              bike_id: bike.id,
              zipcode_id: zipcode.nil? ? zipcode : zipcode.id,
              subscription_type_id: subscription.id)
end
