# frozen_string_literal: true

require 'uri'
require 'net/http'

class Location
  BASE_URI = 'https://maps.googleapis.com/maps/api/geocode/json'

  attr_reader :address

  # Create a new Location instance
  #
  # @param address [String] The address of the location
  def initialize address
    @address = address
  end

  # The zipcode for the location
  #
  # @return [String] the zipcode
  def zipcode
    data['address_components'].find { |component| component['types'].include? 'postal_code' }['short_name']
  end

  # The latitude of the location
  #
  # @return [Float] the latitude
  def latitude
    data['geometry']['location']['lat']
  end

  # The longitude of the location
  #
  # @return [Float] the longitude
  def longitude
    data['geometry']['location']['lng']
  end

  # Methods below this are mainly meant for internal use, but not protected to allow easier testing.

  # URL for Geocoding this location
  #
  # @return [URI] the URL that will be requested to retrieve goecoding data
  def url
    uri = URI.parse BASE_URI
    uri.query = URI.encode_www_form params
    uri
  end

  # Parameters to pass to Geocoding service
  #
  # @return [Hash] Geocoding parameters
  def params
    {
      key: ENV['GOOGLE_MAP_API_KEY'],
      address:,
    }
  end

  # Make HTTP request to get data from address returned by #url method
  #
  # @return [String] the HTTP response body
  def get
    Net::HTTP.get(url)
  end

  # Parse JSON data returned by #get method, this may include metadata
  #
  # @return [Hash]
  def parse
    JSON.parse get
  end

  # Pull out the part of the response data that we're actually looking for.
  # This will ignore, any additional metadata returned by the service.
  #
  # This also stores the result in an instance variable to avoid repeated
  # requests and parsing.
  #
  # @return [Hash]
  def data
    @data ||= parse['results'].first
  end
end
