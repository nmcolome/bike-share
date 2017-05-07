require './spec/spec_helper'

RSpec.describe SubscriptionType do
  describe "validations" do
    it "can make valid subscriptions" do
      subscription_type = SubscriptionType.new(sub_type: "weekly")

      expect(subscription_type).to be_valid
    end

    it "is invalid without name" do
      subscription_type = SubscriptionType.new

      expect(subscription_type).to_not be_valid
    end
  end
end
