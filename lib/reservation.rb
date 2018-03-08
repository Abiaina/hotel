require 'date'

class Reservation
  # Will be an issue for date overlap.
  # CHECKOUT_ADJUSTER = 1

  attr_reader :end_date, :start_date, :stay, :cost

  def initialize(start_date, end_date, room_id)
    valid = true
    if valid_dates?(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
    else
      valid = false
    end
    stay_length if valid

    if !@stay || !valid
      raise ArgumentError.new("Invalid date(s)")
    end

    @room_id = room_id
  end

  def valid_dates?(start_date, end_date)
    valid = true
    begin
      Date.parse(start_date)
      Date.parse(end_date)
    rescue
      valid = false
    end
    return valid
  end

  def stay_cost
    @cost = @stay * 200
  end

  def stay_length
    @stay = false
    date_order = @start_date <=> @end_date
    if date_order < 0
      @stay = (@end_date.mjd - @start_date.mjd)
      stay_cost
    end
  end
end
