require 'time'

class Room

  # attr_accessor :status
  attr_reader :cost, :id

  def initialize (id)
    @id = id
    @cost = 200
  end

end
