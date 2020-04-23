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
    end
  end
end