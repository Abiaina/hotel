require 'date'
require_relative 'room'
require_relative 'reservation'

class Admin
  attr_reader :roomlist, :reservations, :price

  def initialize
    @roomlist = []
    @reservations = []

    20.times do |i|

      @roomlist << Room.new(i + 1)
    end

    return @roomlist
  end

  def new_reservation (alpha, omega)
    new_stay = Reservation.new(alpha, omega)
    @reservations << new_stay
  end

  def reservation_price (index)
    @price = @reservations[index].stay_days * 200
    return price
  end
end
