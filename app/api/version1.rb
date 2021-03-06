require_relative '../../config/application'

module MyApi
  class CinemaApiV1 < Grape::API
    version 'v1', :using => :path
    format :json

    resource :movies do
      params do
        requires :dow, type: {value: Integer, message: "type is invalid, must be an integer"}
      end
      desc "Movies by dow"
      get '/by_day/:dow' do
          {movies: Dow.find(dow: params[:dow])&.movies}
      end

      params do
        requires :name, type: String
        optional :description, type: String
        optional :img_url, type: String
      end
      desc "Create a movie"
      post '/create_movie' do
        Movie.create(name: params[:name], description: params[:description], img_url: params[:img_url])
      end
    end

    resource :bookings do
      helpers BookingsHelper

      params do
        requires :movie_id, type: {value: Integer, message: "type is invalid, must be an integer"}
        requires :quantity, type: {value: Integer, message: "type is invalid, must be an integer"}
        requires :date, type: String, values: ->(v) {DateTime.parse(v).to_date >= DateTime.now.beginning_of_day.to_date}
        requires :client_id, type: String
      end
      desc "A user can book tickets for a movie"
      post '/book_movie' do
        if !movie_available_on_date? params[:movie_id], params[:date]
          {message: "Movie not available for that day of week", status: 400 }
        elsif !can_book? params[:movie_id], params[:date], params[:quantity]
          {message: "We're sorry, you can take up to #{bookings_left params[:movie_id], params[:date]} tickets", status: 400}
        else
          b = Booking.new
          b.date = DateTime.parse(params[:date]).utc.to_date
          b.client_id = params[:client_id]
          b.movie_id = params[:movie_id]
          b.quantity = params[:quantity]
          b.save
          {message: b, status: 201}
        end
      end

      params do
        requires :start_date, type: String
        requires :end_date, type: String
      end
      desc "Retrieve Bookings on a given date range"
      get '/date_range' do
        Booking.where(date: (DateTime.parse(params[:start_date]).utc.beginning_of_day..DateTime.parse(params[:end_date]).utc.end_of_day))
      end
    end
  end
end