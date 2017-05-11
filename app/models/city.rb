class City < ActiveRecord::Base
  has_many :stations
  has_many :weather_statistic
  validates :name, presence: true
end
