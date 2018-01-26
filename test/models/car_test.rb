
require 'test_helper'

class CarTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'valid car' do
    Car = Car.new(model: 'crv', number: '123')
    assert car.valid?
  end

  test 'invalid without model' do
    car = Car.new(number: '123',)
    refute car.valid?, 'car is valid without a model'
    assert_not_nil car.errors[:model]
  end

  test 'invalid without number' do
    car = Car.new(model: 'crv')
    refute car.valid?
    assert_not_nil car.errors[:number]
  end
end
