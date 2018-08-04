## Question 1 ####################################################

# You are given the following code:

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

# What is the result of calling

oracle = Oracle.new
oracle.predict_the_future

# the above will return: 
"You will (a sentence from the choices method)"

## Question 2 ####################################################

# We have an Oracle class and a RoadTrip 
# class that inherits from the Oracle class.

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

# What is the result of the following:

trip = RoadTrip.new
trip.predict_the_future

# the above will return: 
"You will (a sentence from the choices method defined in RoadTrip)"

## Question 3 ####################################################

# How do you find where Ruby will look for a method 
# when that method is called? How can you find an 
# object's ancestors?

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

# What is the lookup chain for Orange and HotSauce?

# call Object::ancestors
# The lookup chain for Orange and HotSauce is as follows:

# Orange
# Taste
# Object
# Kernel
# BasicObject

# HotSauce
# Taste
# Object
# Kernel
# BasicObject


## Question 4 ####################################################

# What could you add to this class to simplify it 
# and remove two methods from the class definition 
# while still maintaining the same functionality?

class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end

# You could get rid of the custom getter and 
# setter methods for type by adding:

attr_accessor :type

# now we can also delete the '@' that is prepended to type
# in the describe_type method

## Question 5 ####################################################

# There are a number of variables listed below. 
# What are the different types and how do you 
# know which is which?

excited_dog = "excited dog"   # local var. Snake case and nothing prepended to it
@excited_dog = "excited dog"  # instance var. Begins with '@'
@@excited_dog = "excited dog" # class var. Begins with '@@'

## Question 6 ####################################################

# If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# Which one of these is a class method (if any) 
# and how do you know? How would you call a class method?

# we know that .manufacturer is a class method because it begins
# with self. You would invoke it directly from the class:

Television.manufacturer

## Question 7 ####################################################

# If we have a class such as the one below:


class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end




# Explain what the @@cats_count variable does and how it works. 
# What code would you need to write to test your theory?

# @@cats_count is used to keep track of how many instances of 
# the Cat class currently exist in your program. Every time a Cat
# object is instantiated, the .initialize method increments the 
# class variable, @@cats_count, by one. The Cat::cats_count
# method returns the value of @@cats_count.

# I will test this theory by writing the following:

tom = Cat.new 'Black cat'
p Cat.cats_count             #=> 1
garfield = Cat.new 'Cartoon'
p Cat.cats_count             #=> 2

## Question 8 ####################################################

# If we have this class:

class Game
  def play
    "Start the game!"
  end
end

# And another class:

class Bingo
  def rules_of_play
    #rules of play
  end
end
# What can we add to the Bingo class to allow 
# it to inherit the play method from the Game class?

# simply make it inherit from the Game class like so:

class Bingo < Game
  # code
end

## Question 9 ####################################################

# If we have this class:

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

# What would happen if we added a play method to 
# the Bingo class, keeping in mind that there is 
# already a method of this name in the Game class 
# that the Bingo class inherits from.

# the Bingo#play method would override the Game#play method. 
# Whatever code was given to Bingo#play would be executed rather
# than the code inside Game#play.

## Question 10 ###################################################

# What are the benefits of using Object Oriented Programming 
# in Ruby? Think of as many as you can.

# OOP cuts gets rid of too much dependency in your code
# OOP allows you to group similar functionality together
# OOP allows you to model real world objects and functionality
#   and use them in your program. Basically it makes it easier to
#   create real world situations in code.
# OOP allows you to section off your code and think more in depth
#   about individual parts of your program

# These given by launch school :
# Creating objects allows programmers to think more abstractly about the code they are writing.
# Objects are represented by nouns so are easier to conceptualize.
# It allows us to only expose functionality to the parts of code that need it, meaning namespace issues are much harder to come across.
# It allows us to easily give functionality to different parts of an application without duplication.
# We can build applications faster as we can reuse pre-written code.
# As the software becomes more complex this complexity can be more easily managed.


