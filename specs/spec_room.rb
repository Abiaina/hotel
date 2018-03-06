require 'date'
require_relative 'spec_helper'

describe 'room' do
  it "room initializes and returns a single instance of room" do
    test = Room.new(1)
    test.must_be_instance_of Room
  end

  it "cost instance variable returns the price of room per night in integer" do
    test = Room.new(1)
    test.cost.must_equal 200
  end

  it "id instance variable returns the id of the room." do
    test = Room.new(3)
    test.room_id.must_equal 3
  end
end
