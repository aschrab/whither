require 'test_helper'
require 'minitest/mock'
require 'net/http'

class LocationTest < ActiveSupport::TestCase
  def setup
    @address = '1 Infinite Loop, Cupertino, CA'
    @location = Location.new @address
  end

  def test_that_address_has_location
    assert_equal @address, @location.address
  end

  def test_that_params_are_generated
    key = 'fakekey'
    expected = { key:, address: @location.address }
    ClimateControl.modify GOOGLE_MAP_API_KEY: key do
      assert_equal expected, @location.params
    end
  end

  def test_geolocation_url_generation
    ClimateControl.modify GOOGLE_MAP_API_KEY: 'fake' do
      expected = 'https://maps.googleapis.com/maps/api/geocode/json?key=fake&address=1+Infinite+Loop%2C+Cupertino%2C+CA'
      assert_equal expected, @location.url.to_s
    end
  end

  def test_retrieval
    response = 'FAKE_RESPONSE'
    Net::HTTP.stub :get, response do
      assert_equal response, @location.get
    end
  end

  def test_latitude
    Net::HTTP.stub :get, response_body do
      assert_equal 37.3318598, @location.latitude
    end
  end

  def test_longitude
    Net::HTTP.stub :get, response_body do
      assert_equal(-122.0302485, @location.longitude)
    end
  end

  def test_zipcode
    Net::HTTP.stub :get, response_body do
      assert_equal '95014', @location.zipcode
    end
  end

  def response_body
    <<-END_OF_RESPONSE
      {
         "results" : [
            {
               "address_components" : [
                  { "long_name" : "Infinite Loop 1", "short_name" : "Infinite Loop 1", "types" : [ "premise" ] },
                  { "long_name" : "1", "short_name" : "1", "types" : [ "street_number" ] },
                  { "long_name" : "Infinite Loop", "short_name" : "Infinite Loop", "types" : [ "route" ] },
                  { "long_name" : "Cupertino", "short_name" : "Cupertino", "types" : [ "locality", "political" ] },
                  { "long_name" : "Santa Clara County", "short_name" : "Santa Clara County", "types" : [ "administrative_area_level_2", "political" ] },
                  { "long_name" : "California", "short_name" : "CA", "types" : [ "administrative_area_level_1", "political" ] },
                  { "long_name" : "United States", "short_name" : "US", "types" : [ "country", "political" ] },
                  { "long_name" : "95014", "short_name" : "95014", "types" : [ "postal_code" ] },
                  { "long_name" : "2083", "short_name" : "2083", "types" : [ "postal_code_suffix" ] }
               ],
               "formatted_address" : "Infinite Loop 1, 1 Infinite Loop, Cupertino, CA 95014, USA",
               "geometry" : {
                  "bounds" : {
                     "northeast" : { "lat" : 37.3321786, "lng" : -122.0297996 },
                     "southwest" : { "lat" : 37.3312158, "lng" : -122.0305776 }
                  },
                  "location" : { "lat" : 37.3318598, "lng" : -122.0302485 },
                  "location_type" : "ROOFTOP",
                  "viewport" : {
                     "northeast" : { "lat" : 37.3330203302915, "lng" : -122.0289424197085 },
                     "southwest" : { "lat" : 37.3303223697085, "lng" : -122.0316403802915 }
                  }
               },
               "place_id" : "ChIJAf9D3La1j4ARuwKZtGjgMXw",
               "types" : [ "premise" ]
            }
         ],
         "status" : "OK"
      }
    END_OF_RESPONSE
  end
end
