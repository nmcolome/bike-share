require './spec/spec_helper'

RSpec.describe Bike do
  describe "validations" do
    it "can make valid bikes" do
      bike = Bike.new(bike: 670)

      expect(bike).to be_valid
    end

    it "is invalid without name" do
      bike = Bike.new

      expect(bike).to_not be_valid
    end
  end
end
