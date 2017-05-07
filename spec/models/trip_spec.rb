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
end
