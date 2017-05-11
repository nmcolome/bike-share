require_relative '../spec_helper'

RSpec.describe "When a user visits '/trips'" do
  it "they can delete a trip from /trips" do
    date = DateRef.create!(date: "2010-01-01")
    date1 = DateRef.create!(date: "2010-02-01")
    city = City.create!(name: "Denver")
    station = Station.create!(name: "Broadway", dock_count: 10, city_id: city.id, date_ref_id: date.id)
    bike = Bike.create!(bike: 100)
    zipcode = Zipcode.create!(zipcode: 10010)
    subscription = SubscriptionType.create!(sub_type: "Weekly")
    Trip.create!(duration: 5000, date_ref_id: date.id, end_date_id: date1.id, start_station_id: station.id, end_station_id: station.id, zipcode_id: zipcode.id, bike_id: bike.id, subscription_type_id: subscription.id)


    visit('/trips')
    expect(Trip.count).to eq(1)
    click_on "Delete"

    expect(Trip.count).to eq(0)
    expect(current_path).to eq("/trips")
  end

  it "they can delete a trip from /tripsid" do
    date = DateRef.create!(date: "2010-01-01")
    date1 = DateRef.create!(date: "2010-02-01")
    city = City.create!(name: "Denver")
    station = Station.create!(name: "Broadway", dock_count: 10, city_id: city.id, date_ref_id: date.id)
    bike = Bike.create!(bike: 100)
    zipcode = Zipcode.create!(zipcode: 10010)
    subscription = SubscriptionType.create!(sub_type: "Weekly")
    trip = Trip.create!(duration: 5000, date_ref_id: date.id, end_date_id: date1.id, start_station_id: station.id, end_station_id: station.id, zipcode_id: zipcode.id, bike_id: bike.id, subscription_type_id: subscription.id)


    visit("/trips/#{trip.id}")
    expect(Trip.count).to eq(1)
    click_on "Delete"

    expect(Trip.count).to eq(0)
    expect(current_path).to eq("/trips")
  end
end