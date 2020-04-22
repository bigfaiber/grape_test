require_relative '../../config/application'
require 'json'
module MyApi
  class CinemaApiV1 < Grape::API
    version 'v1', :using => :path
    format :json

    resource :movies do
      desc "Movies by dow"
      get '/by_day/:dow' do
        {movies: Dow.find(dow: params[:dow].to_i).movies}
      end

    end
  end
end