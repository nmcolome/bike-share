require './spec/spec_helper'

RSpec.describe WeatherStatistic do
  describe "validations" do
    it "can make a valid weather info" do
      date = DateRef.new(date: 2012-01-01)
      weather = WeatherStatistic.new(max_temperature: 1, mean_temperature: 1, min_temperature: 1, mean_humidity: 1, mean_visibility: 1, mean_wind_speed:1, precipitation:1, date_ref_id: 1)

      expect(weather).to be_valid
    end

    it "is valid without a max_temperature" do
      weather = WeatherStatistic.new(mean_temperature: 1, min_temperature: 1, mean_humidity: 1, mean_visibility: 1, mean_wind_speed:1, precipitation:1, date_ref_id: 1)

      expect(weather).to_not be_valid
    end

    it "is valid without a mean_temperature" do
      weather = WeatherStatistic.new(max_temperature: 1, min_temperature: 1, mean_humidity: 1, mean_visibility: 1, mean_wind_speed:1, precipitation:1, date_ref_id: 1)

      expect(weather).to_not be_valid
    end

    it "is valid without a min_temperature" do
      weather = WeatherStatistic.new(max_temperature: 1, mean_temperature: 1, mean_humidity: 1, mean_visibility: 1, mean_wind_speed:1, precipitation:1, date_ref_id: 1)

      expect(weather).to_not be_valid
    end

    it "is valid without a mean humidity" do
      weather = WeatherStatistic.new(max_temperature: 1, min_temperature:1, mean_temperature: 1, mean_visibility: 1, mean_wind_speed:1, precipitation:1, date_ref_id: 1)

      expect(weather).to_not be_valid
    end

    it "is valid without a mean visibility" do
      weather = WeatherStatistic.new(max_temperature: 1, min_temperature:1, mean_temperature: 1, mean_humidity: 1, mean_wind_speed:1, precipitation:1, date_ref_id: 1)

      expect(weather).to_not be_valid
    end

    it "is valid without a mean wind speed" do
      weather = WeatherStatistic.new(max_temperature: 1, min_temperature:1, mean_temperature: 1, mean_humidity: 1, mean_visibility: 1, precipitation:1, date_ref_id: 1)

      expect(weather).to_not be_valid
    end

    it "is valid without a precipitation" do
      weather = WeatherStatistic.new(max_temperature: 1, min_temperature:1, mean_temperature: 1, mean_humidity: 1, mean_visibility: 1, mean_wind_speed:1, date_ref_id: 1)

      expect(weather).to_not be_valid
    end

    it "is valid without a date" do
      weather = WeatherStatistic.new(max_temperature: 1, mean_temperature: 1, min_temperature: 1, mean_humidity: 1, mean_visibility: 1, mean_wind_speed:1, precipitation:1)

      expect(weather).to_not be_valid
    end
  end
  
  describe "create_new" do
    it "can create new weather data with params" do
      date = DateRef.new(date: 2012-01-01)
      params = {
        weather: {

          max_temperature:1,
          mean_temperature:2,
          min_temperature:2,
          mean_visibility:2,
          mean_humidity:1,
          mean_wind_speed:1,
          precipitation:2,
          date_ref_id:"2012-01-01",
        }
      }

      weather = WeatherStatistic.create_new(params)

      expect(weather[0]).to be true
      expect(weather[1]).to be_a_kind_of(WeatherStatistic)
      expect(weather[1].id).to eq(1)
      # expect
    end
  end

  describe "update_new" do
    it "can update weather data with params" do
      date = DateRef.new(date: 2012-01-01)
      WeatherStatistic.create!(max_temperature: 1, mean_temperature: 1, min_temperature: 1, mean_humidity: 1, mean_visibility: 1, mean_wind_speed:1, precipitation:1, date_ref_id: 1) 
      
      params = {
        id: 1,
        weather: {
          max_temperature:2,
          mean_temperature:3,
          min_temperature:4,
          mean_visibility:5,
          mean_humidity:6,
          mean_wind_speed:7,
          precipitation:1,
          date_ref_id:"2012-01-01",
        }
      }

      weather = WeatherStatistic.update_record(params)
      expect(weather[1].id).to eq(1)
      expect(weather[1].max_temperature).to eq(2)
      expect(weather[1].mean_temperature).to eq(3)
      expect(weather[1].min_temperature).to eq(4)
      expect(weather[1].mean_visibility).to eq(5)
      expect(weather[1].mean_humidity).to eq(6)
      expect(weather[1].mean_wind_speed).to eq(7)
      expect(weather[1].precipitation).to eq(1.0)
    end
  end

  describe "dashboard" do 
    it "can deliver dashboard data" do
      DateRef.create!(date: '2013-10-10')
      DateRef.create!(date: '2013-10-11')
      DateRef.create!(date: '2013-10-13')
      DateRef.create!(date: '2013-10-14')
      DateRef.create!(date: '2013-10-15')
      DateRef.create!(date: '2013-10-16')
      City.create!(name: "Denver")
      City.create!(name: "San Fran")
      Zipcode.create!(zipcode: "10012")
      Bike.create!(bike: '10012')
      Bike.create!(bike: '10013')
      SubscriptionType.create!(sub_type: "Weekly")
      SubscriptionType.create!(sub_type: "Monthly")
      Station.create!(name: 'Broadway', dock_count: 12, date_ref_id: 1, city_id: 1)
      Station.create!(name: 'Kalamath', dock_count: 15, date_ref_id: 2, city_id: 2)
      Station.create!(name: 'Encino', dock_count: 19, date_ref_id: 3, city_id: 3)
      Trip.create!(duration: 5000, date_ref_id: 1, end_date_id: 1, start_station_id: 1, end_station_id: 2, bike_id:1, subscription_type_id: 1, zipcode_id: 1)
      Trip.create!(duration: 6000, date_ref_id: 1, end_date_id: 1, start_station_id: 1, end_station_id: 2, bike_id:1, subscription_type_id: 1, zipcode_id: 1)
      Trip.create!(duration: 7000, date_ref_id: 2, end_date_id: 1, start_station_id: 1, end_station_id: 2, bike_id:1, subscription_type_id: 1, zipcode_id: 1)
      Trip.create!(duration: 8000, date_ref_id: 2, end_date_id: 1, start_station_id: 1, end_station_id: 2, bike_id:1, subscription_type_id: 1, zipcode_id: 1)
      Trip.create!(duration: 9000, date_ref_id: 3, end_date_id: 1, start_station_id: 1, end_station_id: 2, bike_id:1, subscription_type_id: 1, zipcode_id: 1)
      Trip.create!(duration: 9000, date_ref_id: 4, end_date_id: 1, start_station_id: 1, end_station_id: 2, bike_id:1, subscription_type_id: 1, zipcode_id: 1)
      Trip.create!(duration: 9000, date_ref_id: 5, end_date_id: 1, start_station_id: 1, end_station_id: 2, bike_id:1, subscription_type_id: 1, zipcode_id: 1)
      Trip.create!(duration: 9000, date_ref_id: 6, end_date_id: 1, start_station_id: 1, end_station_id: 2, bike_id:1, subscription_type_id: 1, zipcode_id: 1)
      WeatherStatistic.create!(max_temperature: 49, mean_temperature: 1, min_temperature: 1, mean_humidity: 1, mean_visibility: 1, mean_wind_speed:3, precipitation:0.5, date_ref_id: 1)
      WeatherStatistic.create!(max_temperature: 51, mean_temperature: 1, min_temperature: 1, mean_humidity: 1, mean_visibility: 3, mean_wind_speed:6, precipitation:0.8, date_ref_id: 2)
      WeatherStatistic.create!(max_temperature: 66, mean_temperature: 1, min_temperature: 1, mean_humidity: 1, mean_visibility: 4, mean_wind_speed:12, precipitation:1.2, date_ref_id: 3)
      WeatherStatistic.create!(max_temperature: 72, mean_temperature: 1, min_temperature: 1, mean_humidity: 1, mean_visibility: 5, mean_wind_speed:15, precipitation:0.9, date_ref_id: 4)
      WeatherStatistic.create!(max_temperature: 84, mean_temperature: 1, min_temperature: 1, mean_humidity: 1, mean_visibility: 6, mean_wind_speed:20, precipitation:1.1, date_ref_id: 5)
      WeatherStatistic.create!(max_temperature: 88, mean_temperature: 1, min_temperature: 1, mean_humidity: 1, mean_visibility: 11, mean_wind_speed:20, precipitation:1.0, date_ref_id: 6)

      dash = WeatherStatistic.dashboard
      expect(dash[:breakout_avg_max_min_rides_days_high_temp]).to eq(
      {"0 - 10"=>[4, 4, 4], "10 - 20"=>[0, 0, 0], "20 - 30"=>[0, 0, 0], 
       "30 - 40"=>[0, 0, 0], "40 - 50"=>[2, 2, 2], "50 - 60"=>[2, 2, 2], 
       "60 - 70"=>[1, 1, 1], "70 - 80"=>[1, 1, 1], "80 - 90"=>[1, 1, 1]})

      expect(dash[:breakout_avg_max_min_rides_days_precipitation]).to eq(
        {"0.0 - 0.5"=>[2, 2, 2], "0.5 - 1.0"=>[6, 1, 2], "1.0 - 1.5"=>[4, 1, 1], 
        "1.5 - 2.0"=>[0, 0, 0]}
      )
      
      expect(dash[:breakout_avg_max_min_rides_days_wind_speed]).to eq(
        {"0.0 - 4.0"=>[4, 4, 4], "4.0 - 8.0"=>[2, 2, 2], "8.0 - 12.0"=>[1, 1, 1], 
        "12.0 - 16.0"=>[1, 1, 1], "16.0 - 20.0"=>[1, 1, 1]}
      )
      
      expect(dash[:breakout_avg_max_min_rides_days_visibility]).to eq(
        {"0.0 - 4.0"=>[4, 1, 2], "4.0 - 8.0"=>[2, 1, 1], "8.0 - 12.0"=>[1, 1, 1]}
      )
    end
  end
  
  
  
end
