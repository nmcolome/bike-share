class Station < ActiveRecord::Base
  belongs_to :city
  belongs_to :date_ref
  has_many :trips

  has_many :trip_starts, foreign_key: "start_station_id", class_name: "Trip"
  has_many :trip_ends,   foreign_key: "end_station_id",   class_name: "Trip"

  validates :name, presence: true
  validates :dock_count, presence: true
  validates :city_id, presence: true
  validates :date_ref_id, presence: true


  def self.create_new(params)
    date = Station.validate_date(params)
    station = Station.new(name: params[:station][:name],
                   dock_count: params[:station][:dock_count],
                   city_id: (params[:station][:city_id]),
                   date_ref_id: date
                  )
    [station.save, station]
  end

  def self.update_record(params)
    date = Station.validate_date(params)
    station = Station.find(params[:id])
    status = station.update(
        name: params[:station][:name],
        dock_count: params[:station][:dock_count],
        city_id: (params[:station][:city_id]),
        date_ref_id: date
       )
    [status, station]
  end

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

  def self.individual_dashboard(id)
    {
      rides_started: Trip.where(start_station_id: id).count,
      rides_ended: Trip.where(end_station_id: id).count,
      most_popular_destination: Station.most_popular(id, :end_station),
      most_popular_origin: Station.most_popular(id, :start_station),
      most_popular_date: Station.most_popular(id, :date_ref),
      most_popular_zipcode: Station.most_popular(id, :zipcode),
      most_popular_bike: Station.most_popular(id, :bike),
    }
  end

  def self.most_popular(id, group)
    most_pop = Trip.where(start_station_id: id).group(group).order("count_id DESC").count(:id)
    if most_pop.empty?
      "n/a"
    else
      most_pop.first[0].name
    end
  end

  def self.dashboard_subdata
    {
      maximum_bikes: Station.maximum(:dock_count),
      minimum_bikes: Station.minimum(:dock_count),
      earliest_date: Station.includes(:date_ref).order("date_refs.date ASC").first.date_ref.id,
      latest_date: Station.includes(:date_ref).order("date_refs.date DESC").first.date_ref.id
    }
  end

  def self.validate_name_change(name)
    if equivalent_names[name]
      equivalent_names[name]
    else
      name
    end
  end

  def self.validate_date(params)
    if params[:station][:installation_date].empty?
      ''
    else
      date = DateRef.find_or_create_by(date: params[:station][:installation_date])
      date.id
    end
  end

  def self.equivalent_names
    {
      "San Jose Government Center"=>"Santa Clara County Civic Center",
      "Broadway at Main" =>"Stanford in Redwood City",
      "Post at Kearny" => "Post at Kearney",
      "Washington at Kearny" => "Washington at Kearney"
    }
  end
end
