require './spec/spec_helper'

RSpec.describe Zipcode do
  describe "validations" do
    it "can make valid zipcodes" do
      zipcode = Zipcode.new(zipcode: 67012)

      expect(zipcode).to be_valid
    end

  end
end
