# frozen_string_literal: true

require 'uri'
require 'net/http'

class Weather
  include ApiClient

  attr_reader :location

  def base_uri
    # 'https://api.openweathermap.org/data/3.0/onecall'
    'https://api.openweathermap.org/data/2.5/weather'
  end

  # Creata a new Weather instance
  #
  # @param location [Location] The location for which weather information is wanted.
  #   This object must respond to the #zipcode, #latitude, and #longitude methods.
  def initialize location
    @location = location
  end

  # Parameters to pass to Geocoding service
  #
  # @return [Hash] Geocoding parameters
  def params
    {
      lat: location.latitude,
      lon: location.longitude,
      appid: ENV['OPENWEATHER_API_KEY'],
      exclude: 'alerts,minutely',
    }
  end

  def current = data['main']

  def cache_key = "Weather:#{@location.zipcode}"
  def cache_for = 30.minutes

  def temperature = Temperature.new(current['temp'])
  def low = Temperature.new(current['temp_min'])
  def high = Temperature.new(current['temp_max'])
end
