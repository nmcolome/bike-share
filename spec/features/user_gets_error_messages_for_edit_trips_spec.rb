require_relative '../spec_helper'

RSpec.describe "When a user visits '/trips/id/edit'" do
  it "they see error messages when not edited properly" do
    date = DateRef.create!(date: "2010-01-01")
    city = City.create!(name: "Denver")
    station = Station.create!(name: "Broadway", dock_count: 10, city_id: city.id, date_ref_id: date.id)
    bike = Bike.create!(bike: 100)
    zipcode = Zipcode.create!(zipcode: 10010)
    subscription = SubscriptionType.create!(sub_type: "Weekly")
    trip = Trip.create!(duration: 5000, date_ref_id: date.id, end_date_id: date.id, start_station_id: station.id, end_station_id: station.id, zipcode_id: zipcode.id, bike_id: bike.id, subscription_type_id: subscription.id)

    visit("/trips/#{trip.id}/edit")

    fill_in('trip[bike]', with: '')
    fill_in('trip[end_date]', with: '')
    fill_in('trip[start_date]', with: '')

    click_on("Edit Trip")

    expect(page).to have_content("Bike can't be blank")
    expect(page).to have_content("End date can't be blank")
    expect(page).to have_content("Date ref can't be blank")
  end
end