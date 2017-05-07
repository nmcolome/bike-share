class Bike < ActiveRecord::Base
  has_many :trips
  validates :bike, presence: true
end
