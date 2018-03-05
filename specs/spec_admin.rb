require 'time'
require_relative 'spec_helper'

describe 'admin' do
  it "admin initializes and returns a single instance of admin" do
    test = Admin.new
    test.must_be_instance_of Admin
  end

  it "roomlist instance variable returns list of 20 room instances" do
    test = Admin.new
    test.roomlist.must_be_instance_of Array
    test.roomlist.count.must_equal 20
    test.roomlist[8].must_be_instance_of Room
  end

  it "id instance variable returns the id of the room." do
    test = Admin.new
    rooms = test.roomlist
    rooms[3].id.must_equal 4
  end
end
