class Trip<ActiveRecord::Base
  belongs_to :bike
  belongs_to :zipcode
  belongs_to :subscription_type
  belongs_to :station
  belongs_to :date_ref

  validates :bike_id, presence: true
  validates :subscription_type_id, presence: true
  validates :date_ref_id, presence: true
  validates :end_date_id, presence: true
  validates :start_station_id, presence: true
  validates :end_station_id, presence: true
end
