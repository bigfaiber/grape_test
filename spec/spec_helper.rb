require_relative '../config/application.rb'
require 'capybara/rspec'

RSpec.configure do |config|

  config.mock_with :rspec
  config.expect_with :rspec
  config.formatter = :documentation
end

Capybara.configure do |config|
  config.app = MyApi::CinemaApiV1.new
  config.server_port = 9293
end