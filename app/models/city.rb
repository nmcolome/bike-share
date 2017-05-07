class City < ActiveRecord::Base
  has_many :stations
  validates :name, presence: true

  # def self.organize_array(id)
    # binding.pry
    # object_array = City.all.map {|city| city} - this works
    # to_front = object_array.delete(City.find(id))
    # object_array.unshift(to_front)
  # end
  
end
