require_relative 'spec_helper'

describe 'reservation' do
  before do
    @date1 = '2018-1-10'
    @date2 = '2018-3-5'
  end
  it "initializes and returns a single instance of reservation" do
    test = Reservation.new(@date1, @date2)
    test.must_be_instance_of Reservation
  end

  it "takes in two dates and calculates length of stay" do

    test = Reservation.new(@date1, @date2)
    test_dates = (Date.parse(@date2)).mjd - (Date.parse(@date1)).mjd
    test.stay.must_equal(test_dates)
  end

  it "raises error if end date preceeds start date" do
    proc {
      Reservation.new(@date2, @date1)}.must_raise ArgumentError
    end

    it "raises error if either start or end start date objects are nil" do
      proc {
        Reservation.new(nil, nil)}.must_raise ArgumentError
      end
    end
