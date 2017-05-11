class Zipcode < ActiveRecord::Base
  has_many :trips
  validates :zipcode, presence: true

  def name
    self.zipcode
  end
end
