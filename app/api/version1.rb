require_relative '../../config/application.rb'

module MyApi
  class CinemaApiV1 < Grape::API
    version 'v1', :using => :path
    format :json

    resource :movies do

      desc "Movies by dow"
      get '/:dow' do
        params
      end

    end
  end
end