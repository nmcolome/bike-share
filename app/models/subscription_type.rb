class SubscriptionType<ActiveRecord::Base
  has_many :trips
  validates :sub_type, presence: true
end
