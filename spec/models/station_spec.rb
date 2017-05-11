require './spec/spec_helper'

RSpec.describe Station do
  describe "validations" do
    it "can make valid stations" do
      station = Station.new(name: "Broadway", dock_count: 12, lat: 1.2325, long: 12.54683, date_ref_id: 2, city_id: 1)

      expect(station).to be_valid
    end

    it "is invalid without name" do
      station = Station.new(dock_count: 12, lat: 1.2325, long: 12.54683, date_ref_id: 2, city_id: 1)

      expect(station).to_not be_valid
    end

    it "is invalid without dock_count" do
      station = Station.new(name: "Broadway", lat: 1.2325, long: 12.54683, date_ref_id: 2, city_id: 1)

      expect(station).to_not be_valid
    end

    it "is invalid without city_id" do
      station = Station.new(dock_count: 12, lat: 1.2325, long: 12.54683, date_ref_id: 2, name: "Broadway")

      expect(station).to_not be_valid
    end

    it "is invalid without date_ref_id" do
      station = Station.new(name: "Broadway", lat: 1.2325, long: 12.54683, dock_count: 12, city_id: 1)

      expect(station).to_not be_valid
    end
  end

  describe 'Dashboard' do
    it "gives a dashboard data" do
      city = City.create!(name: 'Denver')
      date = DateRef.create!(date: '2016-01-01')
      date1 = DateRef.create!(date: '2017-02-01')
      station = Station.create!(name: "Broadway", dock_count: 12, lat: 1.2325, long: 12.54683, date_ref_id: date.id, city_id: city.id)
      station_1 = Station.create!(name: "Denver", dock_count: 21, lat: 1.2325, long: 12.54683, date_ref_id: date1.id, city_id: city.id)


      expect(Station.dashboard[:total_count]).to eq(2)
      expect(Station.dashboard[:average_bikes]).to eq(16)
      expect(Station.dashboard[:max_bikes]).to eq(21)
      expect(Station.dashboard[:max_bikes_stations].first.name).to eq('Denver')
      expect(Station.dashboard[:min_bikes]).to eq(12)
      expect(Station.dashboard[:min_bikes_stations].first.name).to eq('Broadway')
      expect(Station.dashboard[:most_recent_stations].first.name).to eq('Broadway')
      expect(Station.dashboard[:oldest_stations].first.name).to eq('Denver')
    end
  end

  describe 'Individual_dashboard' do
    it "outputs dashboard data per station" do
      date1 = DateRef.create(date: "2010-01-01")
      date2 = DateRef.create(date: "2011-02-02")
      date3 = DateRef.create(date: "2012-03-02")

      city = City.create(name: "San Francisco")

      station1 = Station.create!(name: "Broadway", dock_count: 12, lat: 1.2325, long: 12.54683, date_ref_id: date1.id, city_id: city.id)
      station2 = Station.create!(name: "Lawrence", dock_count: 52, lat: 1.2325, long: 12.54683, date_ref_id: date2.id, city_id: city.id)
      station3 = Station.create!(name: "Blake", dock_count: 21, lat: 1.2325, long: 12.54683, date_ref_id: date2.id, city_id: city.id)
      station4 = Station.create!(name: "Turing", dock_count: 10, lat: 1.2325, long: 12.54683, date_ref_id: date3.id, city_id: city.id)

      zipcode1 = Zipcode.create(zipcode: 81625)
      zipcode2 = Zipcode.create(zipcode: 31220)
      zipcode3 = Zipcode.create(zipcode: 10230)
      zipcode4 = Zipcode.create(zipcode: 10001)

      bike1 = Bike.create(bike: 670)
      bike2 = Bike.create(bike: 571)
      bike3 = Bike.create(bike: 272)

      subscription_type1 = SubscriptionType.create(sub_type: "Customer")
      subscription_type2 = SubscriptionType.create(sub_type: "Subscriber")

      trip1 = Trip.create!(duration: 10, date_ref_id: date1.id, end_date_id: date3.id, start_station_id: station3.id, end_station_id: station2.id, bike_id: bike1.id, zipcode_id: zipcode1.id, subscription_type_id: subscription_type1.id)
      trip2 = Trip.create!(duration: 15, date_ref_id: date1.id, end_date_id: date3.id, start_station_id: station3.id, end_station_id: station2.id, bike_id: bike1.id, zipcode_id: zipcode1.id, subscription_type_id: subscription_type1.id)
      trip3 = Trip.create!(duration: 20, date_ref_id: date2.id, end_date_id: date3.id, start_station_id: station3.id, end_station_id: station2.id, bike_id: bike1.id, zipcode_id: zipcode1.id, subscription_type_id: subscription_type1.id)
      trip4 = Trip.create!(duration: 20000, date_ref_id: date2.id, end_date_id: date3.id, start_station_id: station3.id, end_station_id: station2.id, bike_id: bike1.id, zipcode_id: zipcode1.id, subscription_type_id: subscription_type1.id)
      trip5 = Trip.create!(duration: 1000000, date_ref_id: date3.id, end_date_id: date3.id, start_station_id: station1.id, end_station_id: station1.id, bike_id: bike2.id, zipcode_id: zipcode2.id, subscription_type_id: subscription_type1.id)
      trip6 = Trip.create!(duration: 20000, date_ref_id: date3.id, end_date_id: date3.id, start_station_id: station2.id, end_station_id: station3.id, bike_id: bike2.id, zipcode_id: zipcode3.id, subscription_type_id: subscription_type2.id)
      trip7 = Trip.create!(duration: 15000, date_ref_id: date2.id, end_date_id: date3.id, start_station_id: station4.id, end_station_id: station4.id, bike_id: bike2.id, zipcode_id: zipcode4.id, subscription_type_id: subscription_type2.id)
      trip8 = Trip.create!(duration: 50000, date_ref_id: date2.id, end_date_id: date3.id, start_station_id: station1.id, end_station_id: station3.id, bike_id: bike3.id, zipcode_id: zipcode2.id, subscription_type_id: subscription_type2.id)

      dashboard = Station.individual_dashboard(3)
      expect(dashboard[:rides_started]).to eq(2)
      expect(dashboard[:rides_ended]).to eq(1)
      expect(dashboard[:most_popular_destination]).to eq("Broadway")
      expect(dashboard[:most_popular_origin]).to eq("Broadway")
      expect(dashboard[:most_popular_date].to_s).to eq("2011-02-02")
      expect(dashboard[:most_popular_zipcode]).to eq('31220')
      expect(dashboard[:most_popular_bike]).to eq(571)
    end
  end
end
