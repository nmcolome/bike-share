require './app/models/station'
require './app/models/city'
require './app/models/date_ref'
require 'csv'
require "pry"

Station.destroy_all
City.destroy_all
DateRef.destroy_all

def clean_date(date)
  date = date.split("/").map do |date|
    if date.length == 1
      "0"+date
    else
      date
    end
  end
  date[0], date[1] = date[1], date[0]
  date.join('-')
end

def create_date(date)
  if DateRef.find_by(name: date)
    DateRef.find_by(name: date)
  else
    DateRef.create!(date: date, name: date)
  end
end

stations = CSV.open './db/csv/station.csv', headers:true, header_converters: :symbol
stations.each do |row|
  date = row[:installation_date]
  date = clean_date(date)
  date = create_date(date)
  city = City.find_or_create_by(name: row[:city])
  Station.create!(name: row[:name], dock_count: row[:dock_count], lat: row[:lat], long: row[:long], date_ref_id: date.id, city_id: city.id)
end
