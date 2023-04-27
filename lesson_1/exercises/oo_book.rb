# Exercise 1

# How do we create an object in Ruby? Give an example of the creation of an object.

# We can create an object by defining a class and instantiating it by using the `#new` method to create an instance, also known as an object. An example:

class SomeClass
end

foo = SomeClass.new

# Exercise 2

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
