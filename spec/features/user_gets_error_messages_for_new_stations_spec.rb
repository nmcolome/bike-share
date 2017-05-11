require_relative '../spec_helper'

RSpec.describe "When a user visits '/stations/new'" do
  it "they see error messages when not created properly" do

    visit('/stations/new')
    click_button("Create New Station")

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Dock count can't be blank")
    expect(page).to have_content("Date ref can't be blank")
  end
end