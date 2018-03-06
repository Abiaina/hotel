require 'date'

class Room

  # attr_accessor :status
  attr_reader :cost, :room_id

  def initialize(id)
    @cost = 200
    @room_id = id
  end

end
