require 'date'
require 'pry'
require_relative 'spec_helper'

describe 'reservation' do
  it "initializes and returns a single instance of reservation" do
    date1 = "Jan 10 2018"
    date2 = "March 5 2018"
    test = Reservation.new(date1, date2)
    test.must_be_instance_of Reservation
  end

  it "takes in two dates and calculates length of stay" do
    date1 = ("1/10/2018")
    date2 = ("3/5/2018")
    test = Reservation.new(date1, date2)
    test.stay_days.must_equal(Date.parse(date2) - Date.parse(date1) - 1)
  end
end
