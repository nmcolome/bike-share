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
end

