class Bike < ActiveRecord::Base
  has_many :trips
  validates :bike, presence: true

  def name
    self.bike
  end
end
