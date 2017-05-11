require_relative '../spec_helper'

RSpec.describe "When a user visits '/trips/new'" do
  it "they see error messages when not created properly" do
    date = DateRef.create!(date: "2010-01-01")
    city = City.create!(name: "Denver")
    station = Station.create!(name: "Broadway", dock_count: 10, city_id: city.id, date_ref_id: date.id)
    subscription = SubscriptionType.create!(sub_type: "Weekly")

    visit('/trips/new')
    click_button("Create New Trip")

    expect(page).to have_content("Bike can't be blank")
    expect(page).to have_content("Date ref can't be blank")
    expect(page).to have_content("End date can't be blank")
  end
end