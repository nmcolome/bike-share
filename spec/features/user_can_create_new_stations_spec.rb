require_relative '../spec_helper'

RSpec.describe "When a user visits '/stations/new'" do
  it "they see a 'new' form to create a new station" do
    date = DateRef.create!(date: "2010-01-01")
    city = City.create!(name: "Longmont")
    Station.create!(name: "Larimer", dock_count: 10, city_id: city.id, date_ref_id: date.id)

    date1 = DateRef.create!(date: "2010-01-01")
    date2 = DateRef.create!(date: "2010-02-01")
    city = City.create!(name: "Denver")
    station = Station.create!(name: "Broadway", dock_count: 10, city_id: city.id, date_ref_id: date.id)
    bike = Bike.create!(bike: 100)
    zipcode = Zipcode.create!(zipcode: 10010)
    subscription = SubscriptionType.create!(sub_type: "Weekly")
    Trip.create!(duration: 5000, date_ref_id: date1.id, end_date_id: date2.id, start_station_id: station.id, end_station_id: station.id, zipcode_id: zipcode.id, bike_id: bike.id, subscription_type_id: subscription.id)

    visit('/stations/new')
    fill_in("station[name]", with: "15th st")
    fill_in("station[dock_count]", with: 13)
    fill_in("station[installation_date]", with: "2017-10-01")
    select("Denver", from: "station[city_id]")
    
    find("input[type='submit']").click

    expect(current_path).to eq("/stations/3")

    visit('/stations/new')
    expect(page).to have_content("Name:")
    expect(page).to have_content("Dock count:")
    expect(page).to have_content("Installation Date:")
  end

end