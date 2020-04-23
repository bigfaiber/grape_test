module BookingsHelper
  MAX_BOOKINGS = 10
  attr_accessor :bookings, :datetime
  def movie_available_on_date? movie_id, date
    @datetime = DateTime.parse(date)
    Movie[movie_id].dows.include? Dow.find(dow: @datetime.wday)
  end

  def can_book? movie_id, date, quantity
    @bookings = Booking.where(date: (@datetime.beginning_of_day..@datetime.end_of_day),
                              movie_id: movie_id).sum(:quantity)
    if bookings.nil? && quantity
      quantity <= MAX_BOOKINGS
    else
      bookings + quantity <= MAX_BOOKINGS
    end
  end


  def bookings_left movie_id, date
    if @bookings.nil?
      return MAX_BOOKINGS
    else
      MAX_BOOKINGS - Booking.where(date: (@datetime.beginning_of_day..@datetime.end_of_day),
                                   movie_id: movie_id).sum(:quantity)
    end
  end
end
