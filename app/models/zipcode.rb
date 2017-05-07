class Zipcode < ActiveRecord::Base
  has_many :trips
  validates :zipcode, presence: true
end
