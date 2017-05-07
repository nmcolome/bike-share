require './app/models/station'
require './app/models/city'
require './app/models/date_ref'
require 'csv'
require "pry"

Station.destroy_all
City.destroy_all
DateRef.destroy_all

stations = CSV.open './db/csv/station.csv', headers:true, header_converters: :symbol
stations.each do |row|
  date = row[:installation_date]
  date = DateRef.clean_date(date)
  date = DateRef.find_or_create_by!(date: date)
  city = City.find_or_create_by!(name: row[:city])
  Station.create!(name: row[:name], dock_count: row[:dock_count], lat: row[:lat], long: row[:long], date_ref_id: date.id, city_id: city.id)
end
