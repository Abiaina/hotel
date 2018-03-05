require 'date'

class Reservation
  CHECKOUT_ADJUSTER = 1
  attr_reader :rez, :end, :start

  def initialize(start_date, end_date)
    @start = Date.parse(start_date)
    @end = Date.parse(end_date)
    return @rez
  end

  def stay_days
    stay = ((@end - @start).to_i - CHECKOUT_ADJUSTER)
    return stay
  end
  
end
