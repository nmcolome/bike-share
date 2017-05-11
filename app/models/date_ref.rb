class DateRef < ActiveRecord::Base
  has_many :stations
  has_many :trips

  validates :date, presence: true

  def self.clean_date(date)
    date = splits(date).map do |d|
      leading_zero(d)
    end
    swap(date).join('-')
  end

  def self.swap(date)
    date[0], date[1], date[2] = date[2], date[0], date[1]
  end

  def self.splits(date)
    date.split(' ')[0].split("/")
  end

  def self.leading_zero(d)
    if d.length == 1
      "0" + d
    else
      d
    end
  end

  def name
    self.date.to_s
  end
end
