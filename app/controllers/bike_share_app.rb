class BikeShareApp < Sinatra::Base

  get '/' do
    erb :index
  end

#station dashboard with statistics
  get '/stations-dashboard' do
    @dashboard_data = Station.dashboard
    erb :'stations/dashboard'
  end
  
#station index landing page
  get '/stations' do
    @stations = Station.all
    erb :"stations/index"
  end

#form for new stations
  get '/stations/new' do  
    @city = City.all
    erb :"stations/new"
  end

#single station page
  get '/stations/:id' do
    @station = Station.find(params[:id])
    @trip_individual_data = Station.individual_dashboard(params[:id].to_i)
    erb :"stations/show"
  end

#route after filling new station form
  post '/stations' do
    @station = Station.create_new(params)

    redirect "/stations/#{@station.id}"
  end

#form to edit station
  get '/stations/:id/edit' do
    @city = City.all
    @station = Station.find(params[:id])
    erb :"stations/edit"
  end

#route to update after editing station
  put '/stations/:id' do
    @station = Station.update_record(params)
    redirect "/stations/#{@station.id}"
  end

#route to delete single station
  delete '/stations/:id' do
    @station = Station.destroy(params[:id])
    redirect "/stations"
  end

  ###################################
  ##TRIPS
  ###################################

#trip dashboard with statistics
  get '/trips-dashboard' do
    @trips_dashboard_data = Trip.dashboard
    erb :'trips/dashboard'
  end

#trips index landing page
  get '/trips' do
    # binding.pry
    if params[:page].nil? || params[:page] == "1"
      @page = 1  
      @trips = Trip.limit(30)
      erb :"/trips/index"
    else
      @page = params[:page].to_i
      @trips = Trip.limit(30).offset(@page*30)
      if @trips.count == 30
        erb :"/trips/index_b"
      else
        erb :"/trips/index_c"
      end
    end
  end

  #trips index landing page
  get '/trips/page/:id' do
    @trips = Trip.limit(30).offset(params[:page].to_i*30)
    erb :"/trips/index_b"
  end

#form for new trips
  get '/trips/new' do  
    @stations = Station.all
    @subscriptions = SubscriptionType.all
    erb :"trips/new"
  end

#single trip page
  get '/trips/:id' do

    @trip = Trip.find(params[:id])
    erb :'trips/show'
  end

#route after filling new trip form
  post '/trips' do
    trip = Trip.create_new(params)
    redirect "/trips/#{trip.id}"
  end

#form to edit trips
  get '/trips/:id/edit' do
    @trip = Trip.find(params[:id])
    @stations = Station.all
    @subscriptions = SubscriptionType.all
    erb :'trips/edit'
  end

  put '/trips/:id' do
    trip = Trip.update_record(params)
    redirect "/trips/#{trip.id}"
  end

#route to delete single trip
  delete '/trips/:id' do
    @trip = Trip.destroy(params[:id])
    redirect "/trips"
  end
end
