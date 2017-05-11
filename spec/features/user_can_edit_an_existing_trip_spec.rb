require_relative '../spec_helper'

RSpec.describe "When a user visits '/trips/{id}/edit'" do
  it "sees an 'edit' form to edit an existing station" do
    date = DateRef.create!(date: "2010-01-01")
    date1 = DateRef.create!(date: "2010-02-01")
    city = City.create!(name: "Denver")
    station = Station.create!(name: "Broadway", dock_count: 10, city_id: city.id, date_ref_id: date.id)
    bike = Bike.create!(bike: 100)
    zipcode = Zipcode.create!(zipcode: 10010)
    subscription = SubscriptionType.create!(sub_type: "Weekly")
    subscription2 = SubscriptionType.create!(sub_type: "Monthly")
    trip = Trip.create!(duration: 5000, date_ref_id: date.id, end_date_id: date1.id, start_station_id: station.id, end_station_id: station.id, zipcode_id: zipcode.id, bike_id: bike.id, subscription_type_id: subscription.id)


    visit("/trips/1/edit")
    select "Monthly", from: "trip[subscription]"
    fill_in 'trip[start_date]', with: '2010-02-01'
    fill_in 'trip[end_date]', with: '2010-02-02'
    fill_in 'trip[bike]', with: 2000
    fill_in 'trip[zipcode]', with: 20020

    click_on "Edit Trip"

    expect(current_path).to eq("/trips/1")

    expect(page).to have_content("Broadway")
    expect(page).to have_content("Monthly")
    expect(page).to have_content("2010-02-01")
    expect(page).to have_content("2010-02-02")
    expect(page).to have_content("20020")
    expect(page).to have_content("200")
  
  end

  it "sees the form labels" do
    visit('/trips/1/edit')
    expect(page).to have_content("Start Date:")
    expect(page).to have_content("End Date:")
    expect(page).to have_content("Start Station:")
    expect(page).to have_content("End Station")
    expect(page).to have_content("Subscription:")
    expect(page).to have_content("Bike:")
    expect(page).to have_content("Zipcode:")
  end
end


