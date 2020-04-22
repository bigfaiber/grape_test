require 'rspec/core/rake_task'

require_relative 'config/application.rb'

require 'rake'
require 'bundler'
Bundler.setup
require 'grape-raketasks'
require 'grape-raketasks/tasks'

desc 'load environment.'
task :environment do
  require File.expand_path('app/api/version1', File.dirname(__FILE__))
end

namespace :db do

  desc "Creates the database"
  task :create do
    puts "Creating database..."
    system("createdb cinemadb")
  end

  task :reset do
    puts "resetting database"
    system("dropdb cinemadb")
    system("createdb cinemadb")
  end

  task :drop do
    puts "dropping database"
    system("dropdb cinemadb")
  end
end

desc 'Start IRB with application environment loaded'
task :console do
  exec "pry -r./config/application"
end

desc "Run the specs"
task :spec do
  RSpec::Core::RakeTask.new(:spec)
end