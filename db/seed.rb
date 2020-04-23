require_relative '../config/application.rb'

sunday = Dow.find_or_create(name: 'Sunday', dow: 0)
monday = Dow.find_or_create(name: 'Monday', dow: 1)
tuesday = Dow.find_or_create(name: 'Tuesday', dow: 2)
wednesday = Dow.find_or_create(name: 'Wednesday', dow: 3)
thursday = Dow.find_or_create(name: 'Thursday', dow: 4)
friday = Dow.find_or_create(name: 'Friday', dow: 5)
saturday = Dow.find_or_create(name: 'Saturday', dow: 6)

m1 = Movie.find_or_create(name: 'Movie 1', description: "I'm movie 1")
m2 = Movie.find_or_create(name: 'Movie 2', description: "I'm movie 2")
m3 = Movie.find_or_create(name: 'Movie 3', description: "I'm movie 3")
m4 = Movie.find_or_create(name: 'Movie 4', description: "I'm movie 4")
m5 = Movie.find_or_create(name: 'Movie 5', description: "I'm movie 5")
m6 = Movie.find_or_create(name: 'Movie 6', description: "I'm movie 6")
m7 = Movie.find_or_create(name: 'Movie 7', description: "I'm movie 7")
m8 = Movie.find_or_create(name: 'Movie 8', description: "I'm movie 8")
m9 = Movie.find_or_create(name: 'Movie 9', description: "I'm movie 9")
m10 = Movie.find_or_create(name: 'Movie 10', description: "I'm movie 10")

m1.add_dow(sunday) unless m1.dows.include? sunday
m2.add_dow(monday) unless m2.dows.include? monday
m3.add_dow(tuesday) unless m3.dows.include? tuesday
m4.add_dow(wednesday) unless m4.dows.include? wednesday
m5.add_dow(thursday) unless m5.dows.include? thursday
m6.add_dow(friday) unless m6.dows.include? friday
m7.add_dow(saturday) unless m7.dows.include? saturday
m8.add_dow(sunday) unless m8.dows.include? sunday
m9.add_dow(monday) unless m9.dows.include? monday
m10.add_dow(tuesday) unless m10.dows.include? tuesday
