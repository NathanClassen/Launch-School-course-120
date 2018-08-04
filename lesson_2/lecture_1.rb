## Problem 1 ###################################

class Person
  attr_accessor :name

  def initialize name
    @name = name
  end
end

## Problem 2 ###################################

class Person
  attr_accessor :last_name, :first_name

  def initialize name, last_name = ''
    @first_name = name
    @last_name = last_name
  end

  def name
    !last_name.empty? ? @first_name + " #{last_name}" : @first_name
  end
end

## Problem 3 ###################################

class Person
  attr_accessor :last_name, :first_name

  def initialize name
    parse_name name
  end

  def name
    !last_name.empty? ? @first_name + " #{last_name}" : @first_name
  end

  def name=(name)
    parse_name name
  end 

  private

  def parse_name name
    names = name.split
    @first_name = names[0]
    @last_name = names.size > 1 ? names[1] : ''
  end
end

## Problem 4 ###################################

bob = Person.new "Robert Smith"
rob = Person.new "Robert Smith"
tim = Person.new "Timmey Smith"

bob.name == tim.name  # false
bob.name == rob.name  # true

## Problem 5 ###################################

# This persons name is #<Person:0x007f8c53904fc0>

## Problem 6 ###################################

class Person
  attr_accessor :last_name, :first_name

  def initialize name
    parse_name name
  end

  def name
    !last_name.empty? ? @first_name + " #{last_name}" : @first_name
  end

  def name=(name)
    parse_name name
  end 

  private

  def to_s
    name
  end

  def parse_name name
    names = name.split
    @first_name = names[0]
    @last_name = names.size > 1 ? names[1] : ''
  end
end

bob = Person.new "Robert Smith"
puts "This guys name is #{bob}." # This guys name is Robert Smith.
