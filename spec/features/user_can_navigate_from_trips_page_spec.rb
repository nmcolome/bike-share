require_relative '../spec_helper'

RSpec.describe "When a user visits '/stations'" do
  it "they see a welcome message and click a station" do

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


      # As a user
      # When I visit /stations
      visit('/trips')
      # Then I see a station
      expect(page).to have_content("Broadway")
      expect(page).to have_content("100")
      expect(page).to have_content("10010")
      expect(page).to have_content("2010-01-01")
      expect(page).to have_content("2010-02-01")
      expect(page).to have_content("Weekly")


      #Then I click station
      click_link("Trip 1")
      #And it takes me to the station page
      expect(current_path).to eq("/trips/1")
  end

  it "takes you to dashboard page" do
    visit('/trips')
    click_link "Trips Dashboard"

    expect(current_path).to eq('/trips-dashboard')
  end

  it "they can edit a station from '/trips'" do
    visit('/trips')
    # save_and_open_page
    first('.edit').click
    expect(current_path).to eq('/trips/1/edit')
  end

  it "deletes a station from '/trips'" do
    expect(Trip.count).to eq(3)
    visit('/trips')
    first("input[type='submit']").click

    expect(current_path).to eq('/trips')
    expect(Trip.count).to eq(2)
  end

  it "takes you to new trip page" do
    visit('/trips')
    click_link "Add Trip"

    expect(current_path).to eq('/trips/new')
  end

end
