## Question 1 ####################################################

# If we have this code:

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# What happens in each of the following cases:

# case 1:

hello = Hello.new
hello.hi          #=> Hello

# case 2:

hello = Hello.new
hello.bye         #=> NoMethodError Neither Hello nor Greeting have a .bye method

# case 3:

hello = Hello.new
hello.greet       #=> Error due to lack of argumets. ArgumentError Greeting#greet has 1 parameter, not 0

# case 4:

hello = Hello.new
hello.greet("Goodbye") #=> Goodbye

# case 5:

Hello.hi  #=> NoMethodError Hello::hi does not exist. Hello#hi does

## Question 2 ####################################################

# In oder to call Hello.hi (above) I would add the following
#   to the Hello class:

def self.hi
  greeting = Greeting.new
  greeting.greet("Hi there, im the Hello class")
end

## Question 3 ####################################################

# When objects are created they are a separate realization of a particular class.

# Given the class below, how do we create two different instances of this class, both with separate names and ages?

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

# we do this:

bob = AngryCat.new 25, "Bobby"
mark = AngryCat.new 8, "Marcus Arileus" 

## Question 4 ####################################################

# Given the class below, if we created a new instance of 
# the class and then called to_s on that instance we would 
# get something like "#<Cat:0x007ff39b356d30>"

class Cat
  def initialize(type)
    @type = type
  end
end

# How could we go about changing the to_s output on 
# this method to look like this: I am a tabby cat? 
# (this is assuming that "tabby" is the type we passed 
# in during initialization).

# Add the following to Cat:

attr_reader :type

def to_s
  "I am a #{type} cat."
end

## Question 5 ####################################################

# If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# What would happen if I called the methods like shown below?

tv = Television.new
tv.manufacturer    # NoMethodError, trying to call a class method on an object
tv.model           # This will run the Television#model logic

Television.manufacturer # This will run the Television::logic
Television.model        # NoMethodError, trying to call an instance method on a class

## Question 6 ####################################################

# If we have a class such as the one below:

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

# In the make_one_year_older method we have used 
# self. What is another way we could write this method 
# so we don't have to use the self prefix?

# We could replace the self prefix with '@':

def make_one_year_older
  @age += 1
end

## Question 7 ####################################################

# What is used in this class but doesn't add any value?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end

end
 # the return keyword in Light::information





