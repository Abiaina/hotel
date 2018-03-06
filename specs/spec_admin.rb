require 'date'
require_relative 'spec_helper'

describe 'admin' do

  it "admin initializes and returns a single instance of admin" do
    admin_test = Admin.new
    admin_test.must_be_instance_of Admin
  end

  describe 'admin of room' do
    it "roomlist instance variable returns list of 20 room instances" do
      admin_test = Admin.new
      admin_test.roomlist.must_be_instance_of Array
      admin_test.roomlist.count.must_equal 20
      admin_test.roomlist[8].must_be_instance_of Room
    end

    it "id instance variable returns the id of the room." do
      admin_test = Admin.new
      rooms = admin_test.roomlist
      rooms[3].room_id.must_equal 4
    end
  end

  describe 'admin of reservations' do
    it "calculates the length of stay" do
    end

    it "reservations instance variable is an array of reservation instances" do
    end

    describe 'new_reservation' do
      before do
        @date1 = ("1/10/2018")
        @date2 = ("3/5/2018")

        @admin_test = Admin.new

        @bookings = @admin_test.reservations.count
        @test_reservation = @admin_test.new_reservation(@date1, @date2)
      end

      it "every new reserservation increases reservations list by one" do
        @admin_test.reservations.count.must_equal(@bookings + 1)
      end

      it "gives the price of new reservation." do
        price_of_stay = @admin_test.reservation_price (0)
        price_of_stay.must_equal((Date.parse(@date2) - Date.parse(@date1) - 1) * 200)
      end

    end
  end
end
