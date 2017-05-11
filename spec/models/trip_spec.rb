require './spec/spec_helper'

RSpec.describe Trip do
  describe "validations" do
    date = DateRef.create(date: "2010-01-01")
    date2 = DateRef.create(date: "2011-02-02")
    city = City.create(name: "Denver")
    station = Station.create(name: "Broadway", dock_count: 12, lat: 1.2325, long: 12.54683, date_ref_id: date.id, city_id: city.id)
    zipcode = Zipcode.create(zipcode: 81625)
    bike = Bike.create(bike: 670)
    subscription_type = SubscriptionType.create(sub_type: "weekly")


    it "can make valid trips" do
      trip = Trip.new(date_ref_id: date.id, end_date_id: date2.id, start_station_id: station.id, end_station_id: station.id, bike_id: bike.id, zipcode_id: zipcode.id, subscription_type_id: subscription_type.id)

      expect(trip).to be_valid
    end

    it "is invalid without date_ref_id" do
      trip = Trip.new(end_date_id: date2.id, start_station_id: station.id, end_station_id: station.id, bike_id: bike.id, zipcode_id: zipcode.id, subscription_type_id: subscription_type.id)

      expect(trip).to_not be_valid
    end

    it "is invalid without end_date_id" do
      trip = Trip.new(date_ref_id: date.id, start_station_id: station.id, end_station_id: station.id, bike_id: bike.id, zipcode_id: zipcode.id, subscription_type_id: subscription_type.id)

      expect(trip).to_not be_valid
    end

    it "is invalid without start_station_id" do
      trip = Trip.new(date_ref_id: date.id, end_date_id: date2.id, end_station_id: station.id, bike_id: bike.id, zipcode_id: zipcode.id, subscription_type_id: subscription_type.id)

      expect(trip).to_not be_valid
    end

    it "is invalid without end_station_id" do
      trip = Trip.new(date_ref_id: date.id, end_date_id: date2.id, start_station_id: station.id, bike_id: bike.id, zipcode_id: zipcode.id, subscription_type_id: subscription_type.id)

      expect(trip).to_not be_valid
    end

    it "is invalid without bike id" do
      trip = Trip.new(date_ref_id: date.id, end_date_id: date2.id, start_station_id: station.id, end_station_id: station.id, zipcode_id: zipcode.id, subscription_type_id: subscription_type.id)

      expect(trip).to_not be_valid
    end
    it "is inavalid without zipcode" do
      trip = Trip.new(date_ref_id: date.id, end_date_id: date2.id, start_station_id: station.id, end_station_id: station.id, bike_id: bike.id, subscription_type_id: subscription_type.id)
    end

    it "is invalid without subscription id" do
      trip = Trip.new(date_ref_id: date.id, end_date_id: date2.id, start_station_id: station.id, end_station_id: station.id, bike_id: bike.id, zipcode_id: zipcode.id)
    end
  end

  describe "sterilize" do
    it "creates hash of params data" do
      date = DateRef.create(date: "2010-01-01")
      date2 = DateRef.create(date: "2011-02-02")
      city = City.create(name: "Denver")
      station = Station.create!(name: "Broadway", dock_count: 12, lat: 1.2325, long: 12.54683, date_ref_id: date.id, city_id: city.id)
      zipcode = Zipcode.create(zipcode: 81625)
      bike = Bike.create(bike: 670)
      subscription_type = SubscriptionType.create(sub_type: "weekly")

      params = {
        :trip =>
          {
            start_date: "2013-05-05",
            end_date: "2013-05-05",
            bike: "1001",
            zipcode: "10010",
            subscription: "weekly",
            start_station: station.id,
            end_station: station.id
          }
      }

      result = Trip.sterilize(params)  

      expect(result[:start_date]).to eq(3)
      expect(result[:end_date]).to eq(3)
      expect(result[:bike]).to eq(2)
      expect(result[:zipcode]).to eq(2)
      expect(result[:subscription]).to eq(1)
      expect(result[:start_station].name).to eq('Broadway')
      expect(result[:end_station].name).to eq('Broadway')
    end
  end

  describe "update_record" do
    it "creates updated hash of params data" do
      date = DateRef.create(date: "2010-01-01")
      date2 = DateRef.create(date: "2011-02-02")
      city = City.create(name: "Denver")
      station = Station.create!(name: "Broadway", dock_count: 12, lat: 1.2325, long: 12.54683, date_ref_id: date.id, city_id: city.id)
      station1 = Station.create!(name: "Lawrence", dock_count: 12, lat: 1.2325, long: 12.54683, date_ref_id: date.id, city_id: city.id)
      zipcode = Zipcode.create(zipcode: 81625)
      bike = Bike.create(bike: 670)
      subscription_type = SubscriptionType.create(sub_type: "weekly")
      subscription_type2 = SubscriptionType.create(sub_type: "Monthly")
      trip = Trip.create!(date_ref_id: date.id, end_date_id: date2.id, start_station_id: station.id, end_station_id: station.id, bike_id: bike.id, zipcode_id: zipcode.id, subscription_type_id: subscription_type.id)

      params = {
        :id => trip.id,
        :trip =>
          {
            start_date: "2013-08-05",
            end_date: "2013-05-04",
            bike: "10012",
            zipcode: "10012",
            subscription: "Monthly",
            start_station: station1.id,
            end_station: station1.id
          }
      }

      trip = Trip.update_record(params)  

      
      expect(trip[1].date_ref.date.to_s).to eq('2013-08-05')
      expect(trip[1].end_date.date.to_s).to eq('2013-05-04')
      expect(trip[1].bike.bike).to eq(10012)
      expect(trip[1].zipcode.zipcode).to eq('10012')
      expect(trip[1].subscription_type.sub_type).to eq("Monthly")
      expect(trip[1].start_station.name).to eq('Lawrence')
      expect(trip[1].end_station.name).to eq('Lawrence')
    end
  end
  
  describe "dashboard" do
    it "creates hash of dashboard data" do
      date1 = DateRef.create(date: "2010-01-01")
      date2 = DateRef.create(date: "2011-02-02")
      date3 = DateRef.create(date: "2012-03-02")

      city = City.create(name: "San Francisco")
      
      station1 = Station.create!(name: "Broadway", dock_count: 12, lat: 1.2325, long: 12.54683, date_ref_id: date1.id, city_id: city.id)
      station2 = Station.create!(name: "Lawrence", dock_count: 52, lat: 1.2325, long: 12.54683, date_ref_id: date2.id, city_id: city.id)
      station3 = Station.create!(name: "Blake", dock_count: 21, lat: 1.2325, long: 12.54683, date_ref_id: date2.id, city_id: city.id)
      station4 = Station.create!(name: "Turing", dock_count: 10, lat: 1.2325, long: 12.54683, date_ref_id: date3.id, city_id: city.id)

      zipcode = Zipcode.create(zipcode: 81625)

      bike1 = Bike.create(bike: 670)
      bike2 = Bike.create(bike: 571)
      bike3 = Bike.create(bike: 272)

      subscription_type1 = SubscriptionType.create(sub_type: "Customer")
      subscription_type2 = SubscriptionType.create(sub_type: "Subscriber")

      trip1 = Trip.create!(duration: 10, date_ref_id: date1.id, end_date_id: date3.id, start_station_id: station3.id, end_station_id: station2.id, bike_id: bike1.id, zipcode_id: zipcode.id, subscription_type_id: subscription_type1.id)
      trip2 = Trip.create!(duration: 15, date_ref_id: date1.id, end_date_id: date3.id, start_station_id: station3.id, end_station_id: station2.id, bike_id: bike1.id, zipcode_id: zipcode.id, subscription_type_id: subscription_type1.id)
      trip3 = Trip.create!(duration: 20, date_ref_id: date2.id, end_date_id: date3.id, start_station_id: station3.id, end_station_id: station2.id, bike_id: bike1.id, zipcode_id: zipcode.id, subscription_type_id: subscription_type1.id)
      trip4 = Trip.create!(duration: 20000, date_ref_id: date2.id, end_date_id: date3.id, start_station_id: station3.id, end_station_id: station2.id, bike_id: bike1.id, zipcode_id: zipcode.id, subscription_type_id: subscription_type1.id)
      trip5 = Trip.create!(duration: 1000000, date_ref_id: date3.id, end_date_id: date3.id, start_station_id: station1.id, end_station_id: station1.id, bike_id: bike2.id, zipcode_id: zipcode.id, subscription_type_id: subscription_type1.id)
      trip6 = Trip.create!(duration: 20000, date_ref_id: date3.id, end_date_id: date3.id, start_station_id: station2.id, end_station_id: station3.id, bike_id: bike2.id, zipcode_id: zipcode.id, subscription_type_id: subscription_type2.id)
      trip7 = Trip.create!(duration: 15000, date_ref_id: date2.id, end_date_id: date3.id, start_station_id: station4.id, end_station_id: station4.id, bike_id: bike2.id, zipcode_id: zipcode.id, subscription_type_id: subscription_type2.id)
      trip8 = Trip.create!(duration: 50000, date_ref_id: date2.id, end_date_id: date3.id, start_station_id: station1.id, end_station_id: station3.id, bike_id: bike3.id, zipcode_id: zipcode.id, subscription_type_id: subscription_type2.id)

      dashboard = Trip.dashboard  

      
      expect(dashboard[:average_duration_ride]).to eq(138130)
      expect(dashboard[:longest_ride].values).to eq(["Broadway", "Broadway", "Days: 11 Hours: 13 Min: 46 Sec: 40"])
      expect(dashboard[:shortest_ride].values).to eq(["Blake", "Lawrence", "Hours: 00 Min: 00 Sec:10"])
      expect(dashboard[:popular_starting_station]).to eq('Blake')
      expect(dashboard[:popular_ending_station]).to eq('Lawrence')
      expect(dashboard[:month_breakdown]).to eq({2012.0=>{"March"=>2}, 2011.0=>{"February"=>4}, 2010.0=>{"January"=>2}, 2013.0=>{"August"=>1}})
      expect(dashboard[:most_ridden_bike]).to eq(670)
      expect(dashboard[:least_ridden_bike]).to eq(10012)
      expect(dashboard[:subscription_breakout]).to eq({"Customer"=>[5, 0.56], "Subscriber"=>[3, 0.33], "Monthly"=>[1, 0.11]})
      expect(dashboard[:top_trip_date][0].to_s).to eq("2011-02-02")
      expect(dashboard[:lowest_trip_date][0].to_s).to eq("2013-08-05")
    end
  end

  describe
end
