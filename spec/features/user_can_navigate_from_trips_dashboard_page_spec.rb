require_relative '../spec_helper'

RSpec.describe "When a user visits '/trips-dashboard'" do
  it "they see dashboard data labels" do
    date = DateRef.create!(date: "2010-01-01")
    date1 = DateRef.create!(date: "2010-02-01")
    city = City.create!(name: "Denver")
    station = Station.create!(name: "Broadway", dock_count: 10, city_id: city.id, date_ref_id: date.id)
    bike = Bike.create!(bike: 100)
    zipcode = Zipcode.create!(zipcode: 10010)
    subscription = SubscriptionType.create!(sub_type: "Weekly")
    subscription1 = SubscriptionType.create!(sub_type: "Monthly")
    Trip.create!(duration: 5000, date_ref_id: date.id, end_date_id: date1.id, start_station_id: station.id, end_station_id: station.id, zipcode_id: zipcode.id, bike_id: bike.id, subscription_type_id: subscription.id)
    Trip.create!(duration: 5000, date_ref_id: date.id, end_date_id: date1.id, start_station_id: station.id, end_station_id: station.id, zipcode_id: zipcode.id, bike_id: bike.id, subscription_type_id: subscription1.id)  
    Trip.create!(duration: 5000, date_ref_id: date.id, end_date_id: date1.id, start_station_id: station.id, end_station_id: station.id, zipcode_id: zipcode.id, bike_id: bike.id, subscription_type_id: subscription1.id)  

    visit('/trips-dashboard')
    # save_and_open_page
    expect(page).to have_content("Average duration of ride:")
    expect(page).to have_content("Longest ride:")
    expect(page).to have_content("Shortest ride")
    expect(page).to have_content("Stations with the most ride as a starting place:")
    expect(page).to have_content("Station with the most ride as an ending place")
    expect(page).to have_content("Month by month breakdown of number of rides with subtotals for each year:")
    expect(page).to have_content("Most ridden bike with total number of rides:")
    expect(page).to have_content("Least ridden bike with total number of rides:")
    expect(page).to have_content("User subscription type:")
    expect(page).to have_content("Single date with highest number of trips:")
    expect(page).to have_content("Single date with lowest number of trips:")

    expect(page).to have_content("500")
    expect(page).to have_content("Broadway, Ended at: Broadway")
    expect(page).to have_content("Hours: 1 Min: 23 Sec:20")
    expect(page).to have_content("Broadway, Ended at: Broadway")
    expect(page).to have_content("1 Min: 23 Sec:20")
    expect(page).to have_content("Broadway")
    expect(page).to have_content("2010")
    expect(page).to have_content("January	3")
    expect(page).to have_content("100")
    expect(page).to have_content("0.67")
    expect(page).to have_content("0.33")
    expect(page).to have_content("Date: January 01, 2010")
    expect(page).to have_content("Trips: 3")
    expect(page).to have_content("Date: January 01, 2010")
    expect(page).to have_content("Trips: 3")  
  end

  it "they can click on all trips" do
    visit('/trips-dashboard')

    click_link('All Trips')

    expect(current_path).to eq("/trips")
  end

  it "they can click on new trips" do
    visit('/trips-dashboard')

    click_link('Create New Trip')

    expect(current_path).to eq("/trips/new")
  end

end
