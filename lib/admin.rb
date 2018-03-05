require 'time'
require_relative 'room.rb'

class Admin
  attr_reader :roomlist

  def initialize
    @roomlist = []

    20.times do |i|
      i += 1
      @roomlist << Room.new(i)
    end

    return @roomlist
  end

end
