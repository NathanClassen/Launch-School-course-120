module Pickup
  @bed = 'Empty'
  attr_reader :bed
  def fill_empty_bed
    @bed == 'Empty' ? @bed = 'Full' : @bed = 'Empty'
  end
end

class Vehicle
  @@vehicles = 0

  def self.number_of_vehicles
    @@vehicles
  end
  
  attr_accessor :color
  attr_reader :year, :model, :speed, :engine

  def initialize(year, color, model)  
    @year = year
    @color = color
    @model = model
    @engine = 'off'
    @speed = 0
    @@vehicles += 1
  end

  def self.mileage gallons, miles
    puts "#{miles / gallons} miles per gallon"
  end

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
    puts "---current status:"
    p "current speed: #{self.speed}mph"
    "Engine is #{self.engine}"
  end

  def age
    p "Your vehicle is about #{calculate_age} years old."
  end


  private

  def calculate_age
    time = Time.new
    time_elapsed = (time - Time.new(year))
    days_elapsed = time_elapsed / 60 / 60 / 24
    years_old = (days_elapsed / 365).round
  end
end

class MyCar < Vehicle
  STYLE = 'Sedan'
end

class MyTruck < Vehicle
  FUEL = 'Diesel'

  include Pickup
end
#puts "----Vehicle----"
#puts Vehicle.ancestors
#puts "----MyCar----"
#puts MyCar.ancestors
#puts "----MyTruck----"
#puts MyTruck.ancestors