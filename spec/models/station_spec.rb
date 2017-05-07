require './spec/spec_helper'

RSpec.describe Station do
  describe "validations" do
    it "can make valid stations" do
      station = Station.new(name: "Broadway", dock_count: 12, lat: 1.2325, long: 12.54683, date_ref_id: 2, city_id: 1)

      expect(station).to be_valid
    end

    it "is invalid without name" do
      station = Station.new(dock_count: 12, lat: 1.2325, long: 12.54683, date_ref_id: 2, city_id: 1)

      expect(station).to_not be_valid
    end

    it "is invalid without dock_count" do
      station = Station.new(name: "Broadway", lat: 1.2325, long: 12.54683, date_ref_id: 2, city_id: 1)

      expect(station).to_not be_valid
    end

    it "is invalid without city_id" do
      station = Station.new(dock_count: 12, lat: 1.2325, long: 12.54683, date_ref_id: 2, name: "Broadway")

      expect(station).to_not be_valid
    end

    it "is invalid without date_ref_id" do
      station = Station.new(name: "Broadway", lat: 1.2325, long: 12.54683, dock_count: 12, city_id: 1)

      expect(station).to_not be_valid
    end
  end

  describe 'Dashboard' do
    it "gives a dashboard data" do
      city = City.create!(name: 'Denver')
      date = DateRef.create!(date: '2016-01-01')
      date1 = DateRef.create!(date: '2017-02-01')
      station = Station.create!(name: "Broadway", dock_count: 12, lat: 1.2325, long: 12.54683, date_ref_id: date.id, city_id: city.id)
      station_1 = Station.create!(name: "Denver", dock_count: 21, lat: 1.2325, long: 12.54683, date_ref_id: date1.id, city_id: city.id)


      expect(Station.dashboard[:total_count]).to eq(2)
      expect(Station.dashboard[:average_bikes]).to eq(16)
      expect(Station.dashboard[:max_bikes]).to eq(21)
      expect(Station.dashboard[:max_bikes_stations].first.name).to eq('Denver')
      expect(Station.dashboard[:min_bikes]).to eq(12)
      expect(Station.dashboard[:min_bikes_stations].first.name).to eq('Broadway')
      expect(Station.dashboard[:most_recent_stations].first.name).to eq('Broadway')
      expect(Station.dashboard[:oldest_stations].first.name).to eq('Denver')
    end
  end
end
