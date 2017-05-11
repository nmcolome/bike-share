require_relative '../spec_helper'

RSpec.describe "When a user visits '/conditions/new'" do
  it "they see error messages when not created properly" do

    visit('/conditions/new')
    click_on("Create New Weather")

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
