class WeatherController < ApplicationController
  def index
    if params[:address]
      @location = Location.new params[:address]
      @weather = Weather.new @location
    else
      @weather = {}
    end
  end
end
