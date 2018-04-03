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
    if @reservations.count > 4 || !@blocked_rooms_ids.include?(reservation.room_id)
      raise ArgumentError.new("Room Block")
    else
      @reservations << reservation
    end
  end

  # Valid to make this block?
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

  # Modified this method
  def reserve_block
    new_rez = Reservation.new(@block.check_in.to_s, @block.check_out.to_s, @block.blocked_rooms_ids[0])

    @block.add_reservation(new_rez)

    return new_rez
  end

end
