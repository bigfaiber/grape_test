
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

desc "setup test database"
task :prep_test do
  puts "Deleting old test db... if it exits"
  File.delete 'db/cinema_test.db' if File.exists? 'db/cinema_test.db'
  puts "Creating test db... "
  $db = Sequel.connect('sqlite://db/cinema_test.db')
  p "running migrations"
  system "sequel -m db/migrate/ sqlite://db/cinema_test.db"
  puts "Seeding database..."
  ruby './db/seed.rb'
  puts "Done"
end

# desc "Run the specs"
# task :spec do
#   RSpec::Core::RakeTask.new(:spec)
# end