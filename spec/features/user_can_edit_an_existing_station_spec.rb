require_relative '../spec_helper'

RSpec.describe "When a user visits '/stations/{id}/edit'" do
  it "sees an 'edit' form to edit an existing station" do
    date = DateRef.create!(date: "2010-01-01")
    city = City.create!(name: "Denver")
    station = Station.create!(name: "Broadway", dock_count: 10, city_id: city.id, date_ref_id: date.id)

    visit("/stations/#{station.id}/edit")
    fill_in("station[name]", with: "15th st")
    fill_in("station[dock_count]", with: 13)
    fill_in("station[installation_date]", with: "2017-10-01")
    click_on "Edit Station"
    id = station.id

    expect(current_path).to eq("/stations/#{id}")
    expect(page).to have_content("15th st")
    expect(Station.first.name).to eq("15th st")
    expect(Station.first.dock_count).to eq(13)
    expect(page).to have_content("2017-10-01")
    expect(page).to have_content("Denver")
  end

  it "sees the form labels" do
    # date = DateRef.create!(date: "2010-01-01")
    # city = City.create!(name: "Denver")
    # station1 = Station.create!(name: "Broadway", dock_count: 10, city_id: city.id, date_ref_id: date.id)
    visit("/stations/1/edit")
    expect(page).to have_content("Name:")
    expect(page).to have_content("Dock Count:")
    expect(page).to have_content("Installation Date:")
  end
end