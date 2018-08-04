## Question 1 #############################

# Which of the following are objects in Ruby? 
# If they are objects, how can you find out what 
# class they belong to?

true
"hello"
[1, 2, 3, "happy days"]
142

# All of the above are classes and you can find out which class
# they belong to by invoking Object#class on them.

## Question 2 #############################

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed     # must include the Speed module

  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed     # must include the Speed module

  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

t = Truck.new
p t.go_fast
             # instantiate objects, call #go_fast to verify
c = Car.new
p c.go_fast

## Question 3 #############################

# When we called the go_fast method from an instance of 
# the Car class (as shown above) you might have noticed 
# that the string printed when we go fast includes the 
# name of the type of vehicle we are using. How is this done?

# this is accomplished via self. Whichever object calls 
# the go_fast method is returned through self, then we call
# .class on whichever object is returned by .self.
# .class Returns the name of the class.

## Question 4 #############################

# If we have a class AngryCat how do we create 
# a new instance of this class?

# The AngryCat class might look something like this:

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

AngryCat.new  # use the 'new' keyword.

## Question 5 #############################

#Which of these two classes has an instance 
# variable and how do you know?

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# Pizze class has an instance variable. It begins with '@'

## Question 6 #############################

# What could we add to the class below to access 
# the instance variable @volume?

class Cube
  def initialize(volume)
    @volume = volume
  end
end

# We could add any of the following

  attr_reader :volume
  
  attr_accessor :volume

  def volume
    @volume
  end

## Question 7 #############################

# What is the default return value of to_s when 
# invoked on an object? Where could you go to find 
# out if you want to be sure?

# by default, to_s returns the objects class name and 
# it's object id.

# you can find this information on the ruby docs

## Question 8 #############################

#If we have a class such as the one below:

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

# You can see in the make_one_year_older method 
# we have used self. What does self refer to here?

# here, self refers to the object that is 
# calling make_one_year_older

## Question 9 #############################

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

# In the name of the cats_count method we 
# have used self. What does self refer to in this context?

# here self refers to the Cat class

## Question 10 ############################

# If we have the class below, what would you 
# need to call to create a new instance of this class.

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

# You would call:

Bag.new('clear', 'polyethylene')
