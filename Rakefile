require 'rspec/core/rake_task'
require 'sequel'
namespace :db do

  desc "Creates the database"
  task :create do
    $db = Sequel.connect('sqlite://db/cinema.db')
    p "database #{$db} created"
  end

  desc "Run migrations"
  task :migrate do
    puts "Running migrations..."
    system "sequel -m db/migrate/ sqlite://db/cinema.db"
    puts "Migrations done"
  end
  desc "Run seed"
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