source "https://rubygems.org"

gem "grape"
gem "sequel"
gem "grape-raketasks"
gem "pry"
group :development do
  gem "sqlite3"
end

group :test do
  gem "rspec", require:false
  gem "rack-test", require: "rack/test"
end

group :production do
  gem "pg"
end
