require 'test_helper'

class TemperatureTest < ActiveSupport::TestCase
  test 'Kelvin to Celsius' do
    assert_equal 0, Temperature.new(273).celsius
  end

  test 'Celsius to Kelvin' do
    assert_equal 373, Temperature.new(100, :celsius).kelvin
  end

  test 'Kelvin to Fahrenheit' do
    assert_equal 32, Temperature.new(273).fahrenheit
  end

  test 'Fahrenheit to Celsius' do
    assert_equal 100, Temperature.new(212, :fahrenheit).celsius
  end

  test 'Meeting point' do
    assert_equal(-40, Temperature.new(-40, :celsius).fahrenheit)
  end
end
