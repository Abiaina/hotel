require 'date'
require_relative 'room.rb'
require_relative 'reservation.rb'

class Admin
  attr_reader :roomlist, :reservations, :price

  def initialize
    @roomlist = []
    @reservations = []

    20.times do |i|
      i += 1
      @roomlist << Room.new(i)
    end

    return @roomlist
  end

  def new_reservation (alpha, omega)
    new_stay = Reservation.new(alpha, omega)
    @reservations << new_stay
  end

  def reservation_price (index)
    @price = @reservation[index].stay_days * room.cost
    return price
  end
end
