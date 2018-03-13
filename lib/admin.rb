require 'date'
require_relative 'reservation'
require_relative 'block_room'

class Admin
  attr_reader :roomlist, :reservations, :price, :blocks

  def initialize
    @roomlist = []
    @reservations = []
    @blocks = []

    20.times do |i|
      @roomlist << (i + 1)
    end
  end

  def add_reservation(check_in, check_out, room_id)
    available_rooms = available_rooms(check_in, check_out)

    if !(available_rooms.include?(room_id))
      raise ArgumentError.new("#{room_id} is booked for these dates")
    end

    if available_rooms.count == 0
      raise ArgumentError.new("No available roooms")
    end

    @reservations << Reservation.new(check_in, check_out, room_id)
  end

  def available_rooms(check_in, check_out)
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

  def new_block(check_in, check_out, number_of_rooms, rate)
    block_rooms_ids = []

    rooms_available = available_rooms(check_in, check_out)

    if number_of_rooms <= 5 && rooms_available.count >= number_of_rooms
      number_of_rooms.times do
        block_rooms_ids << rooms_available[0]
      end

      block = BlockRoom.new(check_in, check_out, rate, block_rooms_ids)

      @blocks << block
    else
      raise ArgumentError.new("Can only block 5 rooms at a time. Can only block available rooms. There are #{available_rooms.count} rooms.")
    end
  end

  def block_add_reservation(block)
    new_rez = Reservation.new(block.check_in.to_s, block.check_out.to_s, block.blocked_rooms_ids[0])

    block.add_reservation(new_rez)

    @reservations << new_rez
  end

  def bookings_by_date(date)
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
