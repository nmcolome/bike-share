class Station < ActiveRecord::Base
  belongs_to :city
  belongs_to :the_date

  validates :name, presence: true
  validates :dock_count, presence: true
  validates :city_id, presence: true
  validates :the_date_id, presence: true
end
