require 'date'

class Trip<ActiveRecord::Base

  belongs_to :bike
  belongs_to :zipcode
  belongs_to :subscription_type
  belongs_to :date_ref
  belongs_to :end_date, :class_name => "DateRef"

  belongs_to :start_station, foreign_key: "start_station_id", class_name: "Station"
  belongs_to :end_station, foreign_key: "end_station_id", class_name: "Station"

  belongs_to :weather_statistic

  validates :bike_id, presence: true
  validates :subscription_type_id, presence: true
  validates :date_ref_id, presence: true
  validates :end_date_id, presence: true
  validates :start_station_id, presence: true
  validates :end_station_id, presence: true

  def name
    "Trip: #{self.id}"
  end

  def self.sterilize(params)
    trip = params[:trip]
    { 
      start_date: validate_date(trip[:start_date]), 
      end_date: validate_date(trip[:end_date]), 
      bike: validate_bike(trip[:bike]),
      zipcode: zip_validate(trip[:zipcode]), 
      subscription: validate_subscription(trip[:subscription]), 
      start_station: Station.find(trip[:start_station].to_i), 
      end_station: Station.find(trip[:end_station].to_i) 
    }
  end

  def self.create_new(params)
    trip_data = sterilize(params)
    trip = Trip.new(date_ref_id: trip_data[:start_date],
                    end_date_id: trip_data[:end_date],
                    start_station_id: trip_data[:start_station].id,
                    end_station_id: trip_data[:end_station].id,
                    bike_id: trip_data[:bike],
                    zipcode_id: trip_data[:zipcode],
                    subscription_type_id: trip_data[:subscription])
      [trip.save, trip]
  end

  def self.update_record(params)
    trip_data = sterilize(params)
    trip = Trip.find(params[:id])
    status = trip.update(date_ref_id: trip_data[:start_date],
                         end_date_id: trip_data[:end_date],
                         start_station_id: trip_data[:start_station].id,
                         end_station_id: trip_data[:end_station].id,
                         bike_id: trip_data[:bike],
                         zipcode_id: trip_data[:zipcode],
                         subscription_type_id: trip_data[:subscription])
    [status, trip]
  end

  def self.dashboard
    {
      average_duration_ride: Trip.average(:duration).to_i,
      longest_ride: ride_data(:maximum),
      shortest_ride: ride_data(:minimum),
      popular_starting_station: popular_stations(:start_station),
      popular_ending_station: popular_stations(:end_station),
      month_breakdown: month_breakdown_data,
      most_ridden_bike: ridden_bike('DESC'),
      least_ridden_bike: ridden_bike('ASC'),
      subscription_breakout: sort_subscription_breakout(subscription_query),
      top_trip_date: sort_hash_merge(trip_date_query('DESC')),
      lowest_trip_date: sort_hash_merge(trip_date_query('ASC'))
    }
  end

  def self.ridden_bike(direction)
    Trip.group(:bike)
        .order("count_id #{direction}")
        .count(:id)
        .first[0]
        .bike
  end

  def self.popular_stations(column)
    Trip.group(column)
        .order("count_id DESC")
        .count(:id).first[0]
        .name
  end

  def self.month_breakdown_data
    break_down = DateRef.distinct
                        .pluck('extract(year from date)')
                        .map{ |date| {date => Trip.sort_trips_by_date(date)}}
    break_down.reduce Hash.new, :merge
  end

  def self.sort_trips_by_date(date)
    trip = query_trips_by_date(date).sort.to_h
    trip.transform_keys do |key|
      Date::MONTHNAMES[key]
    end
  end

  def self.query_trips_by_date(date)
    Trip.joins(:date_ref)
        .where('extract(year from date) = ?', date)
        .group('extract(month from date)')
        .order('count_id DESC')
        .count(:id)
  end

  def self.ride_data(direction)
    duration = Trip.send(direction, :duration)
    trip = Trip.where(duration: duration)
    { 
      start: trip.first.start_station.name,
      end: trip.first.end_station.name,
      duration: convert_duration(duration)
    }
  end

  def self.sort_subscription_breakout(array)
    array.map do |k, v| 
      {
        k.sub_type => [v, (v/Trip.count.to_f).round(2)]
      }
    end.inject(:merge)
  end
  
  def self.subscription_query
   Trip.group(:subscription_type)
       .order("count_id DESC")
       .count(:id) 
  end

  def self.trip_date_query(mode)
    Trip.group(:date_ref)
        .order("count_id #{mode}")
        .count(:id)
  end

  def self.page_load(id)
    Trip.limit(30)
        .offset(id.to_i * 30)
  end

  def self.convert_duration(duration)
    if duration <= 60
      "Hours: 00 Min: 00 Sec:#{duration}"
    elsif ((duration/60)/60) > 23
      days(duration)
    elsif (duration/60) > 59
      hours(duration)
    elsif  
      minutes(duration)
    end
  end
  
  def self.days(duration)
    days = (((duration/60)/60))/24
    hr = ((duration/60)/60) % 24
    mn = (duration/60) % 60
    sc = duration % 60
    "Days: #{days} Hours: #{hr} Min: #{mn} Sec: #{sc}"
  end

  def self.hours(duration)
    hr = ((duration/60)/60)
    mn = (duration/60) % 60
    sc = duration % 60
    "Hours: #{hr} Min: #{mn} Sec:#{sc}"
  end

  def self.minutes(duration)
    sc = duration % 60
    mn = (duration/60).to_i
    "Hours: 00 Min: #{mn} Sec: #{sc}"
  end

  def self.sort_hash_merge(array)
    array.map do |k, v| 
      {k.date => v}
    end.inject(:merge).first
  end

  def self.validate_subscription(subscription)
    if subscription.empty?
      ''
    else
      retrieve_id(:sub, sub_type: subscription)
    end
  end

  def self.validate_bike(bike)
    if bike.empty?
      ''
    else
      retrieve_id(:bike, bike: bike)
    end
  end

  def self.zip_validate(zipcode)
    if  zipcode.nil? || zipcode.empty?
      ''
    else
      retrieve_id(:zip, zipcode: (zipcode[0..4]))
    end
  end
  
  def self.validate_date(date)  
    if date.empty?
      ''
    else
      date = date.split('T')[0]
      retrieve_id(:date, date: date)
    end
  end

  def self.retrieve_id(id, arg)
    object={
      bike: Bike,
      date: DateRef,
      zip: Zipcode,
      sub: SubscriptionType,
    }
    new_obj = object[id].find_or_create_by!(arg)
    new_obj.id
  end

end