require_relative '../spec_helper'

RSpec.describe "When a user visits '/stations'" do
  it "they can delete a station" do
    date = DateRef.create!(date: "2010-01-01")
    city = City.create!(name: "Denver")
    Station.create!(name: "Broadway", dock_count: 10, city_id: city.id, date_ref_id: date.id)

    visit('/stations')
    expect(Station.count).to eq(1)
    click_on "Delete"

    expect(Station.count).to eq(0)
    expect(current_path).to eq("/stations")
  end
end