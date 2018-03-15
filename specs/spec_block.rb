require_relative 'spec_helper'

describe 'blockroom initialize' do
  before do
    @date1 = '2018-1-10'
    @date2 = '2018-3-5'

    @room_block_ids = [1, 2, 3, 4, 5]

    @rate = 150

    @blockroom_test = BlockRoom.new(@date1, @date2, @rate, @room_block_ids.dup)
  end

  it "initializes and returns a single instance of BlockRoom" do
    @blockroom_test.must_be_instance_of BlockRoom
  end

  it "check_in/check_out instance variables are of date class" do
    @blockroom_test.check_in.must_be_instance_of Date
    @blockroom_test.check_out.must_be_instance_of Date
  end

  it "add reservation adds reservation to reservations list" do
    before_rezs =  @blockroom_test.reservations.dup

    5.times do |index|
      @blockroom_test.add_reservation(Reservation.new(@date1, @date2, @room_block_ids[index]))
    end

    count_compare = @blockroom_test.reservations.count > before_rezs.count

    count_compare.must_equal true
  end

  it "raises argument if block is full and add_reservation is called." do
    test_block = BlockRoom.new(@date1, @date2, @rate, @room_block_ids.dup)

    5.times do |index|
      test_block.add_reservation(Reservation.new(@date1, @date2, @room_block_ids[index]))
    end

    proc {
      test_block.add_reservation(Reservation.new(@date1, @date2, @room_block_ids[3]))
    }.must_raise ArgumentError
  end

  describe "reservation in blocked room" do
    before do
      @date1 = '2018-1-10'
      @date2 = '2018-3-5'

      @rate = 150
    end

    it "makes a new reservation instance" do
      room_block_ids = [1, 2, 3, 4, 5]

      test_block = BlockRoom.new(@date1, @date2, @rate, room_block_ids.dup)

      5.times do |index|
        test_block.add_reservation(Reservation.new(@date1, @date2, room_block_ids[index]))
      end

      test_block.reservations[0].must_be_instance_of Reservation
    end

    it "raises error if user tries to make a new reservation instance using invalid room id" do
      room_block_ids = [1, 2, 3, 4, 5]

      test_block = BlockRoom.new(@date1, @date2, @rate, room_block_ids)

      proc {
        test_block.add_reservation(Reservation.new(@date1, @date2, 19))
      }.must_raise ArgumentError
    end

    it "increases the number of reservations in admin" do
      room_block_ids = [1, 2, 3, 4, 5]

      test_block = BlockRoom.new(@date1, @date2, @rate, room_block_ids.dup)

      rezs_before = test_block.reservations.dup

      5.times do |index|
        test_block.add_reservation(Reservation.new(@date1, @date2, room_block_ids[index]))
      end

      count_compare = test_block.reservations.count > rezs_before.count

      count_compare.must_equal true
    end

    it "makes a reservation with the rooom set aside for blocked room" do
      room_block_ids = [1, 2, 3, 4, 5]

      blocked_room_ids = room_block_ids.dup

      test_block = BlockRoom.new(@date1, @date2, @rate, room_block_ids.dup)

      5.times do |index|
        test_block.add_reservation(Reservation.new(@date1, @date2, room_block_ids[index]))
      end

      blocked_room_ids.include?(test_block.reservations[2].room_id).must_equal true
    end
  end

end
