require_relative '../spec_helper'

RSpec.describe "When a user visits '/conditions'" do
  it "they see the conditions list and click on first row" do
    date = DateRef.create!(date: "2010-01-01")
    WeatherStatistic.create!(max_temperature: 1, mean_temperature: 1, min_temperature: 1, mean_humidity: 1, mean_visibility: 1, mean_wind_speed:1, precipitation:1, date_ref_id: 1)

    #As a user
    #Whe I visit conditions
    visit('/conditions')
    #then I see a weather thing
    expect(page).to have_content(1)
    expect(page).to have_content("2010-01-01")

    #then I click on first weather id
    click_link(1)
    #and it takes me to the specific condition page
    expect(current_path).to eq('/conditions/1')
  end

  it "takes user to dashboard page" do
    visit('/conditions')
    click_link "Weather Dashboard"

    expect(current_path).to eq('/conditions-dashboard')
  end

  it "takes user to edit a condition from '/conditions'" do
    visit('/conditions')
    click_link 'Edit'

    expect(current_path).to eq('/conditions/1/edit')
  end

  it "user can delete a condition from '/conditions'" do
    visit('/conditions')
    click_on 'Delete'

    expect(current_path).to eq('/conditions')
    expect(WeatherStatistic.count).to eq(0)
  end

  it "takes user to new condition page" do
    visit('/conditions')
    click_link "Add Weather"

    expect(current_path).to eq('/conditions/new')
  end


end
