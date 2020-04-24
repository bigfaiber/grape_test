require 'grape'
require 'json'
require 'pg'
require 'sequel'
require 'pry'
# $db = Sequel.connect('sqlite://db/cinema.db')
DB = Sequel.connect(ENV['DATABASE_URL'])
require_relative '../app/models/movie'
require_relative '../app/models/dow'
require_relative '../app/models/booking'
require_relative '../app/helpers/bookings_helper'



