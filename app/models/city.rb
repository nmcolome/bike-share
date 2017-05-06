class City < ActiveRecord::Base
  has_many :stations
  validates :name, presence: true
end
