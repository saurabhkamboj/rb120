# Question 2

# In the last question we had the following classes:

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

# If we call Hello.hi we get an error message. How would you fix this?

# Solution

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end

  def self.hi
    greeting = Greeting.new
    greeting.greet("hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# Question 3

# When objects are created they are a separate realization of a particular class.

# Given the class below, how do we create two different instances of this class with separate names and ages?

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

henry = AngryCat.new(12, "Henry")
alex   = AngryCat.new(8, "Alex")

# Question 4

# Given the class below, if we created a new instance of the class and then called to_s on that instance we would get something like "#<Cat:0x007ff39b356d30>"

# How could we go about changing the to_s output on this method to look like this: I am a tabby cat? (this is assuming that "tabby" is the type we passed in during initialization).

class Cat
  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{@type} cat"
  end
end

# Question 6

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

# In the make_one_year_older method we have used self. What is another way we could write this method so we don't have to use the self prefix?

# Solution

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    @age += 1
  end
end
