class MyCar
  def initialize(year, color, model)  
    @year = year
    @color = color
    @model = model
    @engine = 'off'
    @speed = 0
  end

  def self.mileage gallons, miles
    puts "#{miles / gallons} miles per gallon"
  end


  attr_accessor :color, :speed, :engine
  attr_reader :year, :model

  def brake
    self.speed > 0 ? (self.speed -= 5) : (p "You're not moving")
  end

  def accelerate
    engine == 'on' ? (self.speed += 5) : (p "Turn car on first")
  end

  def ignition_turn
    if self.speed == 0
      self.engine == 'on' ? (self.engine = 'off') : (self.engine = 'on')
    else
      p "It's dangerous to turn off a moving vehicle"
    end
  end

  def spray_paint color
    self.color = color
  end

  def to_s
    puts "Your car is a #{color} #{year} #{model}"
  end

  def info
    p self.year
    p self.color
    p self.model
    p self.speed
    p self.engine
  end
end