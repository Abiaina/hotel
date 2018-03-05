require 'date'
require_relative 'room.rb'
require_relative 'reservation.rb'

class Admin
  attr_reader :roomlist, :reservations

  def initialize
    @roomlist = []
    @reservations = []

    20.times do |i|
      i += 1
      @roomlist << Room.new(i)
    end

    return @roomlist
  end

  def new_rez (start_date, end_date)

end
