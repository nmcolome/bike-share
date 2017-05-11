require_relative '../spec_helper'

RSpec.describe "When a user visits '/stations/id/edit'" do
  it "they see error messages when not edited properly" do
    date = DateRef.create!(date: "2010-01-01")
    city = City.create!(name: "Denver")
    station = Station.create!(name: "Broadway", dock_count: 10, city_id: city.id, date_ref_id: date.id)

    visit("/stations/#{station.id}/edit")

    fill_in('station[name]', with: '')
    fill_in('station[dock_count]', with: '')
    fill_in('station[installation_date]', with: '')

    click_on("Edit Station")

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Dock count can't be blank")
    expect(page).to have_content("Date ref can't be blank")
  end
end