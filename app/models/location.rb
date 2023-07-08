# frozen_string_literal: true

require 'uri'
require 'net/http'

class Location
  include ApiClient

  attr_reader :address

  # Create a new Location instance
  #
  # @param address [String] The address of the location
  def initialize address
    @address = address
  end

  # Drill into the data for the interesting part, ignoring metadata
  #
  # @return [Hash]
  def result
    data['results'].first
  end

  # The zipcode for the location
  #
  # @return [String] the zipcode
  def zipcode
    result['address_components'].find { |component| component['types'].include? 'postal_code' }['short_name']
  end

  # The latitude of the location
  #
  # @return [Float] the latitude
  def latitude
    result['geometry']['location']['lat']
  end

  # The longitude of the location
  #
  # @return [Float] the longitude
  def longitude
    result['geometry']['location']['lng']
  end

  # Methods below this are mainly meant for internal use, but not protected to allow easier testing.

  def base_uri
    'https://maps.googleapis.com/maps/api/geocode/json'
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
end
