require_relative 'spec_helper'

describe 'blockroom initialize' do
  before do
    @date1 = Date.parse('2018-1-10')
    @date2 = Date.parse('2018-3-5')

    @room_block_ids = [1, 2, 3, 4, 5]

    @blockroom_test = BlockRoom.new(@date1, @date2, 150, @room_block_ids)
  end

  it "initializes and returns a single instance of BlockRoom" do
    @blockroom_test.must_be_instance_of BlockRoom
  end

  it "check_in/check_out instance variables are of date class" do
    @blockroom_test.check_in.must_be_instance_of Date
    @blockroom_test.check_out.must_be_instance_of Date
  end
end
