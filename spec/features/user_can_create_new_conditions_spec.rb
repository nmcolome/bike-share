require_relative '../spec_helper'

RSpec.describe "When a user visits '/conditions/new'" do
  it "user sees a 'new' form to create a new condition" do
    date = DateRef.create!(date: "2010-01-01")
    date2 = DateRef.create!(date: "2010-02-01")
    WeatherStatistic.create!(max_temperature: 1, mean_temperature: 1, min_temperature: 1, mean_humidity: 1, mean_visibility: 1, mean_wind_speed:1, precipitation:1, date_ref_id: 1)

    visit('/conditions/new')
    fill_in("weather[max_temperature]", with: 60)
    fill_in("weather[mean_temperature]", with: 60)
    fill_in("weather[min_temperature]", with: 60)
    fill_in("weather[mean_humidity]", with: 60)
    fill_in("weather[mean_humidity]", with: 60)
    fill_in("weather[mean_visibility]", with: 60)
    fill_in("weather[mean_wind_speed]", with: 60)
    fill_in("weather[precipitation]", with: 60)
    fill_in("weather[date_ref_id]", with: '2010-02-01')
    click_on("Create New Weather")

    weather = WeatherStatistic.find_by(date_ref_id: 2)

    expect(current_path).to eq("/conditions/#{weather.id}")
    expect(page).to have_content("Maximum Temperature")
    expect(page).to have_content("Average Temperature")
    expect(page).to have_content("Minimum Temperature")

  end
end
