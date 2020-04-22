$:.unshift "app/api"

require 'version1'
MyApi::CinemaApiV1.compile!
run MyApi::CinemaApiV1