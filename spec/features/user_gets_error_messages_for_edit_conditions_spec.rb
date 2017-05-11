require_relative '../spec_helper'

RSpec.describe "When a user visits '/conditions/id/edit'" do
  it "they see error messages when not edited properly" do
    date = DateRef.create!(date: "2010-01-01")
    condition = WeatherStatistic.create!(max_temperature: 1, mean_temperature: 1, min_temperature: 1, mean_humidity: 1, mean_visibility: 1, mean_wind_speed:1, precipitation:1, date_ref_id: 1)

    visit("/conditions/#{condition.id}/edit")

    fill_in("weather[max_temperature]", with: '')
    fill_in("weather[mean_temperature]", with: '')
    fill_in("weather[min_temperature]", with: '')
    fill_in("weather[mean_humidity]", with: '')
    fill_in("weather[mean_visibility]", with: '')
    fill_in("weather[mean_wind_speed]", with: '')
    fill_in("weather[precipitation]", with: '')
    fill_in("weather[date_ref_id]", with: '')

    click_on("Edit Weather")

    expect(page).to have_content("Max temperature can't be blank")
    expect(page).to have_content("Mean temperature can't be blank")
    expect(page).to have_content("Min temperature can't be blank")
    expect(page).to have_content("Mean visibility can't be blank")
    expect(page).to have_content("Mean humidity can't be blank")
    expect(page).to have_content("Mean wind speed can't be blank")
    expect(page).to have_content("Precipitation can't be blank")
    expect(page).to have_content("Precipitation can't be blank")
    expect(page).to have_content("Date ref can't be blank")
  end
end