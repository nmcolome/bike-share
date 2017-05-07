class DateRef < ActiveRecord::Base
  has_many :stations
  has_many :trips

  validates :date, presence: true

  def self.clean_date(date)
    date = date.split(' ')[0].split("/").map do |date|
      if date.length == 1
        "0"+date
      else
        date
      end
    end
    date[0], date[1], date[2] = date[2], date[0], date[1]
    date.join('-')
  end
end
