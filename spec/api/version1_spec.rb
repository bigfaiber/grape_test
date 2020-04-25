
require 'capybara/rspec'
require_relative '../../app/api/version1'
require_relative '../spec_helper'
require 'faker'




describe MyApi::CinemaApiV1, :type => :feature do
  include Rack::Test::Methods

  def app
    MyApi::CinemaApiV1
  end

  context "API endpoints" do

    DB.disconnect
    DB = Sequel.connect('sqlite://db/cinema_test.db')

    context "Non existant endpoint" do

      it "should not load pages that do not exist" do
        visit '/v1/movies/invalid/test'
        expect(page).to have_content "Not Found"
        get '/v1/movies/invalid/test'
        expect(last_response.status).to eq(404)
      end
    end

    context "**MOVIES**" do
      before(:each) do
        @movie = Movie.create(name: Faker::Movies.constants.sample.to_s)
        @dow = Dow.all.sample
        @movie.add_dow(@dow)
      end

      it "get v1/movies/by_day/ -> should get relevant movies" do
        get "v1/movies/by_day/#{@dow.dow}" do
          expect(last_response.status).to eq(200)
        visit "/v1/movies/by_day/#{@dow.dow}"
        expect(page).to have_content @movie.name
        end
      end

      it "post v1/movies/create_movie -> Creates a movie with required params" do
        post "v1/movies/create_movie?name=#{@movie.name}" do
          expect(last_response.body).to have_content @movie.name
          expect(last_response.status).to eq(201)
        end
      end
    end

    context "**BOOKINGS**" do

      before(:each) do
        @date = Date.today
        @wday = @date.wday
        @movie = Movie.create(name: Faker::Movies.constants.sample.to_s)
        @dow = Dow.find(dow: @wday)
        @movie.add_dow(@dow)
        @movie_not_in_date = Movie.create(name: Faker::Movies.constants.sample.to_s)
        @dow_not = Dow.find(dow: @wday + 1)
        @movie_not_in_date.add_dow(@dow_not)
        @client_id = rand(1000000..2000000000)
      end

      it "post v1/bookings/book_movie -> Should create a booking with valid params" do
        post "v1/bookings/book_movie?date=#{@date.strftime("%Y-%m-%d")}&client_id=#{@client_id}&movie_id=#{@movie.id}&quantity=1" do
          expect(last_response.status).to eq(201)
          expect(JSON.parse(last_response.body)["status"]).to eq(201)
        end
      end

      it "post v1/bookings/book_movie -> Should not create a booking if that movie is not shown on that day" do
        post "v1/bookings/book_movie?date=#{@date.strftime("%Y-%m-%d")}&client_id=#{@client_id}&movie_id=#{@movie_not_in_date.id}&quantity=1" do
          expect(JSON.parse(last_response.body)["status"]).to eq(400)
        end
      end

      it "post v1/bookings/book_movie -> Should not create a booking if exceeds capacity" do
        post "v1/bookings/book_movie?date=#{@date.strftime("%Y-%m-%d")}&client_id=#{@client_id}&movie_id=#{@movie.id}&quantity=11" do
          expect(JSON.parse(last_response.body)["status"]).to eq(400)
        end
      end

      it "get v1/bookings/date_range -> Should retrieve Bookings on a given date range" do
        get "v1/bookings/date_range?start_date=2020-01-03&end_date=#{@date.strftime("%Y-%m-%d")}" do
          expect(last_response.status).to eq(200)
          expect(JSON.parse(last_response.body).last["date"]).to have_content(@date.strftime("%Y-%m-%d"))
        end
      end
    end

  end

end