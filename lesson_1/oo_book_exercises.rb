# Exercise 1.1

# How do we create an object in Ruby? Give an example of the creation of an object.

# We can create an object by defining a class and instantiating it by using the `#new` method to create an instance, also known as an object. An example:

class SomeClass
end

foo = SomeClass.new

# Exercise 1.2

# What is a module? What is its purpose? How do we use them with our classes? Create a module for the class you created in exercise 1 and include it properly.

# Just like a class a module allows us to group usable code in one place, however you cannot instantiate an object with a module. We can use a module with a class by including it using the `#include` method followed by the module name.

module SomeModule
  def some_method(argument)
    puts argument
  end
end

class SomeClass
  include SomeModule
end

foo = SomeClass.new
foo.some_method('Hello')

# Exercise 2.1

# Create a class called MyCar. When you initialize a new instance or object of the class, allow the user to define some instance variables that tell us the year, color, and model of the car. Create an instance variable that is set to 0 during instantiation of the object to track the current speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.

class MyCar
  attr_accessor :year, :color, :model, :speed

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def speed_up(number)
    self.speed += number
  end

  def brake(number)
    self.speed -= number
  end

  def shut_off
    self.speed = 0
  end

  def current_speed
    self.speed
  end
end

boleno = MyCar.new(2017, 'black', 'XR')
boleno.speed_up(10)
boleno.speed_up(50)
boleno.brake(30)
puts boleno.current_speed

# alternate

class MyCar
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def speed_up(number)
    @speed += number
  end

  def brake(number)
    @speed -= number
  end

  def shut_off
    @speed = 0
  end

  def current_speed
    @speed
  end
end

boleno = MyCar.new(2017, 'black', 'XR')
boleno.speed_up(10)
boleno.speed_up(50)
boleno.brake(30)
puts boleno.current_speed

# Exercise 2.2

# Add an accessor method to your MyCar class to change and view the color of your car. Then add an accessor method that allows you to view, but not modify, the year of your car.


class MyCar
  attr_accessor :color
  attr_reader :model

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def speed_up(number)
    @speed += number
  end

  def brake(number)
    @speed -= number
  end

  def shut_off
    @speed = 0
  end

  def current_speed
    @speed
  end
end

boleno = MyCar.new(2017, 'black', 'XR')

puts boleno.color
boleno.color = 'grey'
puts boleno.color
puts boleno.year

# Exercise 2.3

# You want to create a nice interface that allows you to accurately describe the action you want your program to perform. Create a method called spray_paint that can be called on an object and will modify the color of the car.

class MyCar
  attr_reader :color
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def speed_up(number)
    @speed += number
  end

  def brake(number)
    @speed -= number
  end

  def shut_off
    @speed = 0
  end

  def current_speed
    @speed
  end

  def spray_paint=(new_color)
    @color = new_color
  end
end

boleno = MyCar.new(2017, 'black', 'XR')

puts boleno.color
boleno.spray_paint = 'grey'
puts boleno.color
puts boleno.year

# alternate

class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def speed_up(number)
    @speed += number
  end

  def brake(number)
    @speed -= number
  end

  def shut_off
    @speed = 0
  end

  def current_speed
    @speed
  end

  def spray_paint(new_color)
    self.color = new_color
  end
end

boleno = MyCar.new(2017, 'black', 'XR')

puts boleno.color
boleno.spray_paint('grey')
puts boleno.color
puts boleno.year

# Exercise 3.1

# Add a class method to your MyCar class that calculates the gas mileage (i.e. miles per gallon) of any car.

class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def speed_up(number)
    @speed += number
  end

  def brake(number)
    @speed -= number
  end

  def shut_off
    @speed = 0
  end

  def current_speed
    @speed
  end

  def spray_paint(new_color)
    self.color = new_color
  end

  def self.mileage(gallons, miles)
    "#{miles / gallons}"
  end
end

boleno = MyCar.new(2017, 'black', 'XR')

puts boleno.color

boleno.spray_paint('grey')
puts boleno.color

puts boleno.year

puts MyCar.mileage(34, 450)

# Exercise 3.2

# Override the to_s method to create a user friendly print out of your object.

class GoodDog
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def to_s
    "The dog's name is #{name}!"
  end
end

sparky = GoodDog.new('Sparky')
puts sparky
