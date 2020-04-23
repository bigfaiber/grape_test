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
          {movies: Dow.find(dow: params[:dow]).movies}
      end

      helpers BookingsHelper

      params do
        requires :movie_id, type: {value: Integer, message: "type is invalid, must be an integer"}
        requires :quantity, type: {value: Integer, message: "type is invalid, must be an integer"}
        requires :date, type: String
        requires :client_id, type: String
      end
      desc "A user can book tickets for a movie"
      post '/book_movie' do
        if can_book? params[:movie_id], params[:date], params[:quantity]
          {message: "that show is full, you can take up to #{bookings_left params[:movie_id], params[:date]} tickets"}
        else
          b = Booking.new
          b.date = DateTime.parse(params[:date])
          b.date -= DateTime.now.offset
          b.client_id = params[:client_id]
          b.movie_id = params[:movie_id]
          b.quantity = params[:quantity]
          b.save
          {message: b, status: 200}
        end
      end
    end
  end
end