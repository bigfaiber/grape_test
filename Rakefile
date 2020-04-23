require 'rspec/core/rake_task'
require_relative 'config/application.rb'

namespace :db do

  desc "Creates the database"
  task :migrate do
    puts "Migrating database..."
    system "sequel -m db/migrate/ sqlite://db/cinema.db"
    puts "database #{$db} migrated"
  end

  task :seed do
    ruby './db/seed.rb'
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