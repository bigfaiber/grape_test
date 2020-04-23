
require 'capybara/rspec'
require_relative '../../app/api/version1'
require_relative '../spec_helper'


$dbtest = Sequel.connect('sqlite://db/cinema.db')
$dbtest = SQLite3::Database.open 'db/cinema_test.db'

describe MyApi::CinemaApiV1, :type => :feature do
  include Rack::Test::Methods

  def app
    MyApi::CinemaApiV1
  end

  context "API endpoints" do

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
        @movie = Movie.find(name: "Movie 3")
      end

      it "get v1/movies/by_day/ -> should get relevant movies" do
        get 'v1/movies/by_day/2' do
          expect(last_response.status).to eq(200)
        visit '/v1/movies/by_day/2'
        expect(page).to have_content @movie.name
        end
      end

      it "post v1/movies/create_movie -> Creates a movie with required params" do
        post 'v1/movies/create_movie?name="movie_test"' do
          expect(last_response.body).to have_content "movie_test"
          expect(last_response.status).to eq(201)
        end
      end
    end

    context "**BOOKINGS**" do
      it "post v1/bookings/book_movie -> Should create a booking with valid params" do
        post 'v1/bookings/book_movie?date=2020-05-03&client_id=1&movie_id=1&quantity=1' do
          expect(last_response.status).to eq(201)
          expect(JSON.parse(last_response.body)["status"]).to eq(201)
        end
      end

      it "post v1/bookings/book_movie -> Should not create a booking if that movie is not shown on that day" do
        post 'v1/bookings/book_movie?date=2020-05-03&client_id=1&movie_id=2&quantity=1' do
          expect(JSON.parse(last_response.body)["status"]).to eq(400)
        end
      end

      it "post v1/bookings/book_movie -> Should not create a booking if exceeds capacity" do
        post 'v1/bookings/book_movie?date=2020-05-03&client_id=1&movie_id=1&quantity=11' do
          expect(JSON.parse(last_response.body)["status"]).to eq(400)
        end
      end

      it "get v1/bookings/date_range -> Should retrieve Bookings on a given date range" do
        get 'v1/bookings/date_range?start_date=2020-01-03&end_date=2020-05-23' do
          expect(last_response.status).to eq(200)
          expect(JSON.parse(last_response.body).last["date"]).to have_content("2020-05-03")
        end
      end
    end

  end

end