require_relative '../spec_helper'

RSpec.describe "When a user visits '/trips/new'" do
  it "they see a 'new' form to create a new trip" do
    date = DateRef.create!(date: "2010-01-01")
    date1 = DateRef.create!(date: "2010-02-01")
    city = City.create!(name: "Denver")
    station = Station.create!(name: "Broadway", dock_count: 10, city_id: city.id, date_ref_id: date.id)
    bike = Bike.create!(bike: 100)
    zipcode = Zipcode.create!(zipcode: 10010)
    subscription = SubscriptionType.create!(sub_type: "Weekly")
    Trip.create!(duration: 5000, date_ref_id: date.id, end_date_id: date1.id, start_station_id: station.id, end_station_id: station.id, zipcode_id: zipcode.id, bike_id: bike.id, subscription_type_id: subscription.id)

    visit('/trips/new')

    select "Broadway", from: "trip[start_station]" 
    select "Broadway", from: "trip[end_station]" 
    select "Weekly", from: "trip[subscription]"
    fill_in 'trip[start_date]', with: '2010-01-01'
    fill_in 'trip[end_date]', with: '2010-01-01'
    fill_in 'trip[bike]', with: bike.bike
    fill_in 'trip[zipcode]', with: 10010

     find("input[type='submit']").click
    
    expect(current_path).to eq("/trips/2")
    expect(page).to have_content("Broadway")
    expect(page).to have_content("Weekly")
    expect(page).to have_content("2010-01-01")
    expect(page).to have_content("10010")
    expect(page).to have_content("100")
    
  end

  it "they see the form labels" do
    visit('/trips/new')
    expect(page).to have_content("Start Date:")
    expect(page).to have_content("End Date:")
    expect(page).to have_content("Start Station:")
    expect(page).to have_content("End Station")
    expect(page).to have_content("Subscription:")
    expect(page).to have_content("Bike:")
    expect(page).to have_content("Zipcode:")
  end
end
