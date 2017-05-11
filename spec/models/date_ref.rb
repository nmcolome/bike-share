require './spec/spec_helper'

RSpec.describe DateRef do
  describe "validations" do
    it "can make valid dates" do
      date = DateRef.new(date: "2010-10-10")

      expect(date).to be_valid
    end

    it "is invalid without date" do
      date = DateRef.new(date: "2010")

      expect(date).to_not be_valid
    end
  end

  describe "clean date" do 
    it "can correctly format date" do
      date = "8/20/2013"
      date = DateRef.clean_date(date)
      expect(date).to eq("2013-08-20")

      date = "10/2/2016"
      date = DateRef.clean_date(date)
      expect(date).to eq("2016-10-02")
    end
  end
  
end
