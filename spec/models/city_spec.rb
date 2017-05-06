require './spec/spec_helper'

RSpec.describe City do
  describe "validations" do
    it "can make valid cities" do
      city = City.new(name: "San Francisco")

      expect(city).to be_valid
    end

    it "is invalid without name" do
      city = City.new

      expect(city).to_not be_valid
    end
  end
end

