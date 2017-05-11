require_relative '../spec_helper'

RSpec.describe "When a user visits '/conditions'" do
  it "they can delete a trip from /conditions" do
    date = DateRef.create!(date: "2010-01-01")
    WeatherStatistic.create!(max_temperature: 1, mean_temperature: 1, min_temperature: 1, mean_humidity: 1, mean_visibility: 1, mean_wind_speed:1, precipitation:1, date_ref_id: 1)

    visit('/conditions')
    expect(WeatherStatistic.count).to eq(1)
    click_on "Delete"

    expect(WeatherStatistic.count).to eq(0)
    expect(current_path).to eq ('/conditions')
  end

  it "user can delete a condition from '/conditions/id'" do
    date = DateRef.create!(date: "2010-01-01")
    weather = WeatherStatistic.create!(max_temperature: 1, mean_temperature: 1, min_temperature: 1, mean_humidity: 1, mean_visibility: 1, mean_wind_speed:1, precipitation:1, date_ref_id: 1)

    visit("/conditions/#{weather.id}")
    click_on "Delete"

    expect(current_path).to eq('/conditions')
    expect(WeatherStatistic.count).to eq(0)
  end
end
