module BookingsHelper
  MAX_BOOKINGS = 10
  def can_book? movie_id, date, quantity
    Booking.where(date: ((DateTime.parse(date) - DateTime.now.offset).beginning_of_day..(DateTime.parse(date) - DateTime.now.offset).end_of_day),
                  movie_id: movie_id).sum(:quantity) + quantity > MAX_BOOKINGS
    #TODO retornar true o false computando parametro quantity de entrada vs 10 spots abiertos, cambiar nombre al metodo, can_book?
  end

  def bookings_left movie_id, date
    MAX_BOOKINGS - Booking.where(date: ((DateTime.parse(date) - DateTime.now.offset).beginning_of_day..(DateTime.parse(date) - DateTime.now.offset).end_of_day),
                  movie_id: movie_id).sum(:quantity)
  end
end
