require 'date'
require_relative 'reservation'
require_relative 'block_room'

class Admin
  attr_reader :roomlist, :reservations, :price

  def initialize
    @roomlist = []
    @reservations = []

    20.times do |i|
      @roomlist << (i + 1)
    end
  end

  def add_reservation(check_in, check_out, room_id, block: 1)
    available_rooms = available_rooms(check_in, check_out)

    if block > 1
      block_helper
    end

    if !(available_rooms.include?(room_id))
      raise ArgumentError.new("#{room_id} is booked for these dates")
    end

    if available_rooms.count == 0
      raise ArgumentError.new("No available roooms")
    end

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

      if valid_check_in && valid_check_out
        rooms.delete(reservation.room_id)
      end
    end

    return rooms
  end
end
