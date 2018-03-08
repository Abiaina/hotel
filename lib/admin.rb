require 'date'
require_relative 'reservation'

class Admin
  attr_reader :roomlist, :reservations, :price

  def initialize
    @roomlist = []
    @reservations = []

    20.times do |i|
      @roomlist << (i + 1)
    end
  end

  def add_reservation(check_in, check_out, room_id)
    @reservations << Reservation.new(check_in, check_out, room_id)
  end

# Move to reservation class and update testing for reservation and admin.

  def reservation_price(index)
    @price = @reservations[index].stay_days * roomlist[0].cost
    return price
  end
### There is no room class required now.

  def bookings_by_date (date)
    bookings_by_day = []

    date = Date.parse(date)

    @reservations.each do |booking|
      if date.between?(booking.start_date, booking.end_date)
        bookings_by_day << booking
      end
    end
    return bookings_by_day
  end
end
