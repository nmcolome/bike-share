class Station < ActiveRecord::Base
  belongs_to :city
  belongs_to :date_ref

  validates :name, presence: true
  validates :dock_count, presence: true
  validates :city_id, presence: true
  validates :date_ref_id, presence: true

  def self.dashboard
    {
      total_count: Station.count,
      average_bikes: Station.average(:dock_count).to_i,
      max_bikes: dashboard_subdata[:maximum_bikes],
      max_bikes_stations: Station.where(dock_count: dashboard_subdata[:maximum_bikes]),
      min_bikes: dashboard_subdata[:minimum_bikes],
      min_bikes_stations: Station.where(dock_count: dashboard_subdata[:minimum_bikes]),
      most_recent_stations: Station.where(date_ref_id: dashboard_subdata[:earliest_date]),
      oldest_stations: Station.where(date_ref_id: dashboard_subdata[:latest_date])
    }
  end

  def self.dashboard_subdata
    {
        maximum_bikes: Station.maximum(:dock_count),
        minimum_bikes: Station.minimum(:dock_count),
        earliest_date: Station.includes(:date_ref).order("date_refs.date").first.date_ref.id,
        latest_date: Station.includes(:date_ref).order("date_refs.date").last.date_ref.id
    }
  end
end
