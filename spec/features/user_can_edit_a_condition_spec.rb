require_relative '../spec_helper'

RSpec.describe "When a user visits '/conditions/edit'" do
  it "user sees an 'edit' form to edit a condition" do
    date = DateRef.create!(date: "2010-01-01")
    WeatherStatistic.create!(max_temperature: 1, mean_temperature: 1, min_temperature: 1, mean_humidity: 1, mean_visibility: 1, mean_wind_speed:1, precipitation:1, date_ref_id: 1)

    visit('/conditions/1/edit')
    fill_in("weather[max_temperature]", with: 60)
    fill_in("weather[mean_temperature]", with: 61)
    fill_in("weather[min_temperature]", with: 62)
    fill_in("weather[mean_humidity]", with: 64)
    fill_in("weather[mean_visibility]", with: 63)
    fill_in("weather[mean_wind_speed]", with: 60)
    fill_in("weather[precipitation]", with: 60)
    fill_in("weather[date_ref_id]", with: "2010-01-01")

    click_on "Edit Weather"

    expect(current_path).to eq("/conditions/1")
    expect(page).to have_content(60)
    expect(page).to have_content(61)
    expect(page).to have_content(62)
    expect(page).to have_content(63)
    expect(page).to have_content(64)
  end

  it "sees the form labels" do
    visit('/conditions/1/edit')
    expect(page).to have_content("Maximum Temperature")
    expect(page).to have_content("Average Temperature")
    expect(page).to have_content("Minimum Temperature")
  end
end
