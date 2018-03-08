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

  def available_rooms (check_in, check_out)

    check_in = Date.parse(check_in)
    check_out = Date.parse(check_out)

    rooms = @roomlist.dup

    @reservations.each do |reservation|
      valid_check_in = check_in.between?(reservation.start_date, (reservation.end_date - 1))

      valid_check_out = check_out.between?((reservation.start_date + 1), reservation.end_date)

      if ! valid_check_in && ! valid_check_out
        rooms.delete(reservation.room_id)
      end
    end

    return rooms
  end
end
