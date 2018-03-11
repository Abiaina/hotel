require_relative 'spec_helper'

describe 'admin initialize' do
  before do
    @admin_test = Admin.new
  end

  it "admin initializes and returns a single instance of admin" do
    @admin_test.must_be_instance_of Admin
  end

  it "roomlist instance variable returns list of 20 room ids" do
    @admin_test.roomlist.must_be_instance_of Array
    @admin_test.roomlist.count.must_equal 20
    @admin_test.roomlist[8].must_be_instance_of Integer
  end
end

describe 'add_reservation' do
  before do
    @date1 = '2018-1-10'
    @date2 = '2018-3-5'

    @admin_test = Admin.new

    @admin_test.add_reservation(@date1, @date2, 1)

    @bookings = @admin_test.reservations

  end

  it "reservations returns list of reservation instances" do
    @bookings.must_be_instance_of Array
    @bookings[0].must_be_instance_of Reservation
  end

  it "can access room id from reservation instance." do
    @bookings[0].room_id.must_equal 1
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

  it "gives the price of new reservation." do
    admin_test_2 = Admin.new

    bookings_2 = admin_test_2.reservations

    admin_test_2.add_reservation(@date1, @date2, 1)

    admin_test_2.reservations[0].cost.must_equal((Date.parse(@date2).mjd - Date.parse(@date1).mjd) * 200)
  end

  it "gives the room_id of new reservation from reservations array" do
    admin_test_2 = Admin.new

    bookings_2 = admin_test_2.reservations

    admin_test_2.add_reservation(@date1, @date2, 1)

    admin_test_2.add_reservation(@date1, @date2, 2)

    admin_test_2.add_reservation(@date1, @date2, 2)

    admin_test_2.reservations[1].room_id.must_equal 2
  end

  it "takes reservation check in and check out date, assigns a room and makes a reservation" do
    admin_test_2 = Admin.new

    admin_test_2.bookings_by_date(@date1).include?(1).must_equal false

    admin_test_2.add_reservation(@date1, @date2, 1)

    admin_test_2.bookings_by_date(@date1)[0].room_id.must_equal 1
  end

  it "assigns available room" do
    admin_test_2 = Admin.new

    admin_test_2.available_rooms(@date1, @date2).include?(1).must_equal true

    admin_test_2.add_reservation(@date1, @date2, 1)

    admin_test_2.available_rooms(@date1, @date2).include?(1).must_equal false

  end

  it "assigned room is not assigned again after being reserved" do
    admin_test_2 = Admin.new

    20.times do |index|
      admin_test_2.add_reservation(@date1, @date2, (index + 1))
    end

    proc {
      admin_test_2.add_reservation(@date1 << 5, @date2 << 5, 1)}.must_raise ArgumentError
    end

    it "raises error if no availble room for check-in/check-out range" do

    end

    describe "bookings_by_date" do

      before do
        booking_dates = [
          ['2018-1-10', '2018-3-5'], ['2018-1-19', '2018-5-2'], ['2018-1-10', '2018-5-5']
        ]

        @admin_test = Admin.new

        booking_dates.each do |dates|
          @admin_test.add_reservation(dates[0], dates[1], 1)
        end

        @date1 = '2018-1-15'
      end

      it "returns an array" do
        bookings_on_test_day = @admin_test.bookings_by_date(@date1)

        bookings_on_test_day.must_be_instance_of Array
        bookings_on_test_day[0].must_be_instance_of Reservation
      end

      it "returns array of reservation instances" do
        bookings_on_test_day = @admin_test.bookings_by_date(@date1)

        bookings_on_test_day.must_be_instance_of Array
        bookings_on_test_day[0].must_be_instance_of Reservation
      end

      it "reservation check_in/check_out date range includes date argument input" do
        bookings_on_test_day = @admin_test.bookings_by_date(@date1)

        Date.parse(@date1).between?(bookings_on_test_day[1].start_date, bookings_on_test_day[1].end_date).must_equal true
      end

      it "returns an empty array if no reservation dates intersect with booking date argument given" do
        bookings_on_test_day = @admin_test.bookings_by_date('2019-1-10')

        bookings_on_test_day.must_be_instance_of Array

        bookings_on_test_day.count.must_equal 0
      end
    end

    describe "available_rooms" do
      before do
        booking_dates = [
          ['2018-1-10', '2018-3-5'], ['2018-1-19', '2018-5-2'], ['2018-1-10', '2018-5-5']
        ]

        @admin_test = Admin.new

        room_id = 1

        booking_dates.each do |dates|
          @admin_test.add_reservation(dates[0], dates[1], room_id)
          room_id += 1
        end
      end

      it "takes valid checkin/checkout dates returns an array of room ids available for the date range" do
        rooms = @admin_test.available_rooms('2018-1-5', '2018-1-9')
        rooms.count.must_equal 20
      end

      it "rooms are available for new reservation check in on last day of existing reservation" do
        rooms = @admin_test.available_rooms('2018-1-5', '2018-1-10')
        rooms.count.must_equal 20
      end

      it "rooms are available for new reservation checkout on first day of existing reservation" do
        rooms = @admin_test.available_rooms('2018-5-5', '2018-5-10')
        rooms.count.must_equal 20
      end

      it "returns list of available rooms without reservations dates that coincide with new reservation date range." do
        rooms = @admin_test.available_rooms('2018-1-21', '2018-2-15')
        rooms.count.must_equal 17
      end

      it "returns empty array of available rooms if hotel is fully booked during new reservation date range." do

        date1 = '2018-1-10'
        date2 = '2018-3-5'

        full_hotel_test = Admin.new

        20.times do |index|
          full_hotel_test.add_reservation(date1, date2, index + 1)
        end

        rooms = full_hotel_test.available_rooms('2018-1-21', '2018-2-15')

        rooms.count.must_equal 0

        rooms.must_be_instance_of Array
      end
    end
  end
