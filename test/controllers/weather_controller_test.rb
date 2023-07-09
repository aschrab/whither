require 'test_helper'

class WeatherControllerTest < ActionDispatch::IntegrationTest
  test 'request for root redirects to weather' do
    get '/'
    assert_redirected_to '/weather'
  end

  test 'request with no address just sends form' do
    get '/weather'
    assert_select 'input[name="address"]', ''
    assert_nil @location
  end

  test 'request with address gives weather for the address' do
    zip = '95014'
    location = Minitest::Mock.new
    location.expect :zipcode, zip

    weather = Minitest::Mock.new
    weather.expect :temperature, Temperature.new(60, :fahrenheit)
    weather.expect :cached?, false

    Location.stub :new, location do
      Weather.stub :new, weather do
        get '/weather', params: { address: '1 Infinite Loop, Cupertino, CA' }
        assert_select '.location', zip
      end
    end

    assert_mock location
    assert_mock weather
  end
end
