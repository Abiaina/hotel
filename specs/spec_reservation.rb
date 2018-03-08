require_relative 'spec_helper'

describe 'reservation' do
  before do
    @date1 = '2018-1-10'
    @date2 = '2018-3-5'
  end

  # NOMINAL
  it "initializes and returns a single instance of reservation" do
    test = Reservation.new(@date1, @date2, 1)
    test.must_be_instance_of Reservation
  end

  it "takes in two dates and calculates length of stay" do
    test = Reservation.new(@date1, @date2, 1)

    test_dates = (Date.parse(@date2)).mjd - (Date.parse(@date1)).mjd

    test.stay.must_equal(test_dates)
  end

  # EDGE TESTING
  it "raises error if end_date & start_date are the same" do
    proc {
      Reservation.new("2018-1-1", "2018-1-1", 1)}.must_raise ArgumentError
  end

  it "stay_length is 1 if end_date & start_date are one day apart" do
    test_3 = Reservation.new("2018-1-1", "2018-1-2", 1)
    test_3.stay.must_equal 1
  end

  it "stay_length is 365 if end_date & start_date are one year apart" do
    test_3 = Reservation.new("2018-1-1", "2019-1-1", 1)
    test_3.stay.must_equal 365
  end

  it "raises error if end date preceeds start date" do
    proc {
      Reservation.new(@date2, @date1, 1)}.must_raise ArgumentError
  end

  it "raises error if either start or end start date objects are nil" do
    proc {
      Reservation.new(nil, @date2, 1)}.must_raise ArgumentError

    proc {
      Reservation.new(@date2, nil, 1)}.must_raise ArgumentError
  end

  it "raises error if both start or end start date objects are nil" do
    proc {
    Reservation.new(nil, nil, 1)}.must_raise ArgumentError
  end

  it "raises error if either start or end start date objects are non-string values" do
    proc {
    Reservation.new(0, @date2, 1)}.must_raise ArgumentError

    proc {
    Reservation.new(@date2, 100, 1)}.must_raise ArgumentError

    proc {
    Reservation.new(@date2, :test_date, 1)}.must_raise ArgumentError
  end

  it "raises error if either start or end start date strings arguments can't be made into Date objects" do
    proc {
    Reservation.new("test_string", @date2, 1)}.must_raise ArgumentError

    proc {
    Reservation.new(@date2, "test_string", 1)}.must_raise ArgumentError
  end
end
