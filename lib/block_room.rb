require 'date'
require_relative 'reservation'

class BlockRoom

  attr_reader :reservations, :blocked_rooms_ids, :check_in, :check_out, :rate

  def initialize(check_in, check_out, rate, blocked_rooms_ids)
    if blocked_rooms_ids.count > 5 || blocked_rooms_ids.count < 1 || rate >= 200
      raise ArgumentError.new("Room Blocks must range 1 to 5 rooms, rate must be <200")
    end

    @check_in = Date.parse(check_in)
    @check_out = Date.parse(check_out)
    @rate = rate
    @reservations = []

    # an array of blocked room's ids
    @blocked_rooms_ids = blocked_rooms_ids
  end

  def add_reservation(reservation)
    if @reservations.count >= 5
      raise ArgumentError.new("Room Block")
    else
      @reservations << reservation
      @blocked_rooms_ids.delete(reservation.room_id)
    end
  end
end
