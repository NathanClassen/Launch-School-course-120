## Question 1 ####################################################

# Ben asked Alyssa to code review the following code:

class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end
# Alyssa glanced over the code quickly and said 
# - "It looks fine, except that you forgot to put 
# the @ before balance when you refer to the balance 
# instance variable in the body of the positive_balance? method."

# "Not so fast", Ben replied. "What I'm doing here is valid - I'm not missing an @!"

# Who is right, Ben or Alyssa, and why?

# Ben is right. Becasue he included the attr_reader :balance
# he should use that getter method to refer to balance.

## Question 2 ####################################################

# Alyssa created the following code to keep track of items for a shopping cart application she's writing:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

# Alan looked at the code and spotted a mistake. 
# "This will fail when update_quantity is called", he says.

# Can you spot the mistake and how to address it?

# Line 42 will mistake this for variable initialization. 
# Alyssa should remedy this by:

attr_accessor :quantity

def update_quantity(updated_count)
  self.quantity = updated_count if updated_count >= 0
end

## Question 3 ####################################################

# In the last question Alyssa showed Alan this code which 
# keeps track of items for a shopping cart application:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

# Alan noticed that this will fail when update_quantity 
# is called. Since quantity is an instance variable, it 
# must be accessed with the @quantity notation when setting it. 
# One way to fix this is to change attr_reader to attr_accessor 
# and change quantity to self.quantity.

# Is there anything wrong with fixing it this way?

# Yes, it makes @quantity changeable without using
# InvoiceEntry#update_quantity. 

## Question 4 ####################################################

# Let's practice creating an object hierarchy.

# Create a class called Greeting with a single 
#   method called greet that takes a string argument and 
#   prints that argument to the terminal.

class Greeting
  def greet(greet_message)
    puts greet_message
  end
end

# Now create two other classes that are derived 
#   from Greeting: one called Hello and one called Goodbye. 
#   The Hello class should have a hi method that takes no 
#   arguments and prints "Hello". The Goodbye class should 
#   have a bye method to say "Goodbye". Make use of the 
#   Greeting class greet method when implementing the Hello 
#   and Goodbye classes - do not use any puts in the Hello 
#   or Goodbye classes.

class Hello < Greeting
  def hi
    greet("Hello!")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye buddy!")
  end
end

## Question 5 ####################################################

# You are given the following class that has been implemented:

class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end
end

# And the following specification of expected behavior:

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
  #=> "Plain"

puts donut2
  #=> "Vanilla"

puts donut3
  #=> "Plain with sugar"

puts donut4
  #=> "Plain with chocolate sprinkles"

puts donut5
  #=> "Custard with icing"

# Write additional code for KrispyKreme such that the puts 
# statements will work as specified above.

# add the following into the body of KrispyKreme:

attr_reader :glazing, :filling_type

def to_s
    case nil
    when glazing
      filling_type == nil ? "Plain" : filling_type
    when filling_type
      "Plain with #{glazing}"
    else
      "#{filling_type} with #{glazing}"
    end
  end

## Question 6 ####################################################

# If we have these two methods:

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end
and

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

# What is the difference in the way the code works?

# The first Computer#create_template method initializes a new
# template instance method and sets it to a string directly, 
# and the first Computer#show_template uses a getter method to
# reference the @template.
# The second set of methods uses self to accomplish both of these
# tasks, which is not neccessary.

## Question 7 ####################################################

# How could you change the method name below so that 
# the method name is more clear and less repetitive.

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.light_information
    "I want to turn on the light with a brightness level of super high and a colour of green"
  end
end

# the class name usually should NOT be included in any of it's
# names. Light::light_information should instead be called:

def self.information
  # code
end
