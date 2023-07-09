class WeatherController < ApplicationController
  def index
    @location = Location.new params[:address]
    return unless params[:address]

    @weather = Weather.new @location
    @weather.get # Force retrieval before starting to render view
  end
end
