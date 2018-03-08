require 'date'

class Reservation
  # Will be an issue for date overlap.
  # CHECKOUT_ADJUSTER = 1

  attr_reader :end_date, :start_date, :stay

  def initialize(start_date, end_date, room_id)
    valid = true
    if valid_dates?(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
    else
      valid = false
    end
    stay_days if valid

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

  def stay_days
    @stay = false
    date_order = @start_date <=> @end_date
    if date_order < 0
      @stay = (@end_date.mjd - @start_date.mjd)
    end
  end

end
