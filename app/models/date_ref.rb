class DateRef < ActiveRecord::Base
  has_many :stations
  validates :date, presence: true

  def self.format_date(date)
    date = date.split("-")
    date[0], date[1], date[2] = 
    date[2], date[1], date[0]
    date.join("-")
  end


  def self.create_date(date)
    date = format_date(date)
    if DateRef.find_by(name: date)
      DateRef.find_by(name: date)
    else
      DateRef.create!(date: date, name: date)
    end
  end
end
