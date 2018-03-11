require 'date'
require_relative 'reservation'

class BlockRoom

  attr_reader :id_array, :check_in, :check_out, :rate

  def initialize(check_in, check_out, rate, id_array)
    if id_array.count > 5 || rate >= 200
      raise ArgumentError.new("Room Blocks limited to 5 rooms, rate must be <200")
    end

    @check_in = check_in
    @check_out = check_out
    @rate = rate
    @id_array = id_array
  end
end
