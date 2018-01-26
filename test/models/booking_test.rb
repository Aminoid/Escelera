require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'valid booking' do
    booking = Booking.new(user_id: '5', car_id: '39')
    assert booking.valid?
  end

  test 'invalid without user_id' do
    booking = Booking.new(car_id: '39',)
    refute booking.valid?, 'booking is valid without a user_id'
    assert_not_nil booking.errors[:user_id]
  end

  test 'invalid without car_id' do
    booking = Booking.new(user_id: '5')
    refute booking.valid?
    assert_not_nil booking.errors[:car_id]
  end
end
