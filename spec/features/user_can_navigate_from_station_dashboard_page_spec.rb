require_relative '../spec_helper'

RSpec.describe "When a user visits '/stations-dashboard'" do
  it "they see dashboard data labels" do
    date = DateRef.create!(date: "2010-01-01")
    date1 = DateRef.create!(date: "2016-01-01")
    date2 = DateRef.create!(date: "2017-01-01")
    date3 = DateRef.create!(date: "2010-03-01")
    date4 = DateRef.create!(date: "2010-04-01")
    city = City.create!(name: "Denver")
    station1= Station.create!(name: "Broadway", dock_count: 10, city_id: city.id, date_ref_id: date.id)
    station2= Station.create!(name: "Market", dock_count: 100, city_id: city.id, date_ref_id: date1.id)
    station3= Station.create!(name: "Turing", dock_count: 1, city_id: city.id, date_ref_id: date1.id)
    station4= Station.create!(name: "Lawrence", dock_count: 11, city_id: city.id, date_ref_id: date2.id)
    station5= Station.create!(name: "Sterling", dock_count: 10, city_id: city.id, date_ref_id: date.id)
    station6= Station.create!(name: "Evergreen", dock_count: 100, city_id: city.id, date_ref_id: date1.id)
    station7= Station.create!(name: "Englewood", dock_count: 1, city_id: city.id, date_ref_id: date1.id)
    bike = Bike.create!(bike: 100)
    zipcode = Zipcode.create!(zipcode: 10010)
    subscription = SubscriptionType.create!(sub_type: "Weekly")
    Trip.create!(duration: 5000, date_ref_id: date3.id, end_date_id: date3.id, start_station_id: station1.id, end_station_id: station1.id, zipcode_id: zipcode.id, bike_id: bike.id, subscription_type_id: subscription.id)
    Trip.create!(duration: 5000, date_ref_id: date3.id, end_date_id: date3.id, start_station_id: station1.id, end_station_id: station1.id, zipcode_id: zipcode.id, bike_id: bike.id, subscription_type_id: subscription.id)
    Trip.create!(duration: 5000, date_ref_id: date4.id, end_date_id: date4.id, start_station_id: station1.id, end_station_id: station1.id, zipcode_id: zipcode.id, bike_id: bike.id, subscription_type_id: subscription.id)

    visit('/stations-dashboard')
    expect(page).to have_content("Total station count")
    expect(page).to have_content("Average bikes per station")
    expect(page).to have_content("Stations with the most bikes available")
    expect(page).to have_content("Bikes per station")
    expect(page).to have_content("Most recently installed station(s)")
    expect(page).to have_content("Oldest station(s)")
  

    visit('/stations-dashboard')
    click_link 'Broadway'

    expect(current_path).to eq('/stations/1')
  end

  it "they can click on all trips" do
    visit('/stations-dashboard')

    click_link('All Station')

    expect(current_path).to eq("/stations")
  end

  it "they can click on new trips" do
    visit('/stations-dashboard')

    click_link('Create New Station')

    expect(current_path).to eq("/stations/new")
  end



end
