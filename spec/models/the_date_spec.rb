require './spec/spec_helper'

RSpec.describe DateRef do
  describe "validations" do
    it "can make valid dates" do
      date = DateRef.new(date: "10-10-2010", name: "10-10-2010")

      expect(date).to be_valid
    end

    it "is invalid without date" do
      date = DateRef.new(name: "10-10-2010")

      expect(date).to_not be_valid
    end
  end
end
