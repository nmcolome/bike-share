require_relative '../spec_helper'

RSpec.describe "When a user visits '/stations'" do
  it "they see a welcome message and click a station" do
    date = DateRef.create!(date: "2010-01-01")
    city = City.create!(name: "Denver")
    Station.create!(name: "Broadway", dock_count: 10, city_id: city.id, date_ref_id: date.id)

      # As a user
      # When I visit /stations
      visit('/stations')
      # Then I see a station
      expect(page).to have_content("Denver")
      expect(page).to have_content("Broadway")
      expect(page).to have_content("10")
      expect(page).to have_content("2010-01-01")

      #Then I click station
      click_link("Broadway")
      #And it takes me to the station page
      expect(current_path).to eq("/stations/1")
  end

  it "takes you to dashboard page" do
    visit('/stations')
    click_link "Stations Dashboard"

    expect(current_path).to eq('/stations-dashboard')
  end

  it "they can edit a station from '/stations'" do
    visit('/stations')
    click_link 'Edit'

    expect(current_path).to eq('/stations/1/edit')
  end

  it "deletes a station from '/stations'" do
    expect(Station.count).to eq(1)
    visit('/stations')
    click_on 'Delete'

    expect(current_path).to eq('/stations')
    expect(Station.count).to eq(0)
  end

  it "takes you to new station page" do
    visit('/stations')
    click_link "Add Station"

    expect(current_path).to eq('/stations/new')
  end

end
