How to run:


1- rake db:create 

2- rake db:migrate

3- rake db:seed

Testing:


1- rake prep_test

2- rake spec

Endpoints:


1) create a movie:


    url= http://localhost:9292/v1/movies/create_movie
    
    params: (name: String, description: String, img_url: String)


2) movie list by a given day of week:


    url= http://localhost:9292/v1/movies/by_day/:dow
    
    dow: Integer is like wday in ruby (Sunday is 0)


3) book a movie show for a given date:


    url= http://localhost:9292/v1/bookings/book_movie
    
    params: (date: "yyyy-mm-dd", client_id: Integer, movie_id: Integer, quantity: Integer)


4) bookings list by given date range:


    url= http://localhost:9292/v1/bookings/date_range
    
    params: (start_date: "yyyy-mm-dd", end_date: "yyyy-mm-dd")


Thanks Gabriela and engineer guy for your time. This was fun, never tried Grape before, neither Sequel.