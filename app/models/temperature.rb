class Temperature
  attr_accessor :kelvin

  def initialize temperature = 0, units = :kelvin
    case units
    when :celsius
      self.celsius = temperature
    when :fahrenheit
      self.fahrenheit = temperature
    else
      @kelvin = temperature
    end
  end

  KELVIN_FREEZE_POINT = 273

  def celsius = @kelvin - KELVIN_FREEZE_POINT

  def celsius= temperature
    @kelvin = temperature + KELVIN_FREEZE_POINT
  end

  FAHRENHEIT_RATIO = 9.0 / 5.0
  FAHRENHEIT_FREEZE = 32
  def fahrenheit = (@kelvin - KELVIN_FREEZE_POINT) * FAHRENHEIT_RATIO + FAHRENHEIT_FREEZE

  def fahrenheit=(temp)
    @kelvin = (temp - FAHRENHEIT_FREEZE) / FAHRENHEIT_RATIO + KELVIN_FREEZE_POINT
  end
end
