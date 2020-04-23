module BookingsHelper
  def get_booking_quantity movie_id, date
    Booking.where(date: (DateTime.parse(date).beginning_of_day..DateTime.parse(date).now.end_of_day),
                  movie_id: movie_id).sum(:quantity)
  end
end