require_relative 'spec_helper'

describe 'admin initialize' do
  before do
    @admin_test = Admin.new
  end

  it "admin initializes and returns a single instance of admin" do
    @admin_test.must_be_instance_of Admin
  end

  it "roomlist instance variable returns list of 20 room instances" do
    @admin_test.roomlist.must_be_instance_of Array
    @admin_test.roomlist.count.must_equal 20
    @admin_test.roomlist[8].must_be_instance_of Room
  end

# Use when room class is deleted.
  # it "id instance variable returns the id of the room." do
  #   rooms = @admin_test.roomlist
  #   rooms[3].room_id.must_equal 4
  # end
end

describe 'add_reservation' do
  before do
    @date1 = '2018-1-10'
    @date2 = '2018-3-5'

    @admin_test = Admin.new

    @bookings = @admin_test.add_reservation(@date1, @date2, 1)

  end

  it "reservations returns list of reservation instances" do
    @bookings.must_be_instance_of Array
    @bookings[0].must_be_instance_of Reservation
  end

  it "calculates the length of stay" do
    @admin_test.reservations[0].stay.must_equal(Date.parse(@date2).mjd - Date.parse(@date1).mjd)
  end

  it "every new reserservation increases reservations list by one" do
    admin_test_2 = Admin.new

    bookings_2 = admin_test_2.reservations.count

    admin_test_2.add_reservation(@date1, @date2, 1)

    admin_test_2.reservations.count.must_equal(bookings_2 + 1)
  end
#
#   it "gives the price of new reservation." do
#     price_of_stay = @admin_test.reservation_price(0)
#
#     price_of_stay.must_equal((Date.parse(@date2) - Date.parse(@date1) - 1) * 200)
#   end
#
#   it "raises error if end date preceeds start date" do
#     proc {
#       admin_test_date_reverse = Admin.new admin_test_date_reverse.new_reservation(@date2, @date1)
#     }.must_raise ArgumentError
#   end
#
#   it "raises error if either start or end start date objects are nil" do
#     proc {
#       admin_test_date_nil = Admin.new admin_test_date_nil.new_reservation(nil, nil)
#     }.must_raise ArgumentError
#   end
# end
#
# describe "bookings_by_date" do
#
#   before do
#     booking_dates = [['1-10-2018', '3-5-2018'], ['1-19-2018', '2-5-2018'], ['1-10-2018', '5-5-2018']]
#
#     @admin_test = Admin.new
#
#     booking_dates.each do |dates|
#       @admin_test.new_reservation(dates[0], dates[1])
#     end
#   end
#
#   it "returns an array of reservation instances" do
#     bookings_on_test_day = @admin_test.bookings_by_date('1-15-2018')
#
#     bookings_on_test_day.must_be_instance_of Array
#     bookings_on_test_day[0].must_be_instance_of Reservation
#   end
#
#   it "returns an empty array if no reservation dates intersect with booking date argument given" do
#     bookings_on_test_day = @admin_test.bookings_by_date('1-15-2019')
#
#     bookings_on_test_day.count.must_equal 0
#   end
#
#   it "raises an error if booking date is not a valid date" do
#     proc {
#       @admin_test.bookings_by_date(nil)
#     }.must_raise ArgumentError
#   end
#
#   it "bookings_by_date array should not exceed the count of admin's reservations" do
#
#   end
end
