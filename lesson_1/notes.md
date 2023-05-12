# Lesson 1 notes

- Encapsulation
- Polymorphism
- Inheritance (Superclass)
- Superclass
- Class
- Module
- Mixin (Module)

> Anything that can be said to have a value is an object. Everything in ruby is an object except methods, blocks, and variables.

- Instantiation

Example of defining a class:

```ruby
class SomeClass
end

foo = SomeClass.new
```

> Use CamelCase naming convention to name classes.

Example of mixing in (mixins) modules into a class:

```ruby
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
```

When defining a class, we focus on two things:

- State
- Behavior

> State refers to the data associated with individual objects.

- Constructor (`#initialize`)
- Instance variable
- Instance method
- Accessor method
- Getter method
- Setter method

- `#attr_accessor`
- `#attr_reader`
- `#attr_writer`

Examples of a constructuor, getter and setter methods within a class:

```ruby
class SomeClass
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def name=(new_name)
    @name = new_name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = SomeClass.new('Sparky')
puts sparky.name
sparky.name = "Gorky"
puts sparky.name
puts sparky.speak
```

> `#initialize` (Constructor) gets called everytime we instantiate a new object via the `#new` method.

Example of using `#attr_accessor` method instead:

```ruby
class SomeClass
  attr_accessor :name # Works for both getting and setting; if you only want to get, use `#attr_reader`; if you only want to set, use `#attr_writer`.

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = SomeClass.new('Sparky')
puts sparky.name
sparky.name = "Gorky"
puts sparky.name
puts sparky.speak
```

- Class method

> Class methods are where we put functionality that does not pertain to individual objects.

Example of using a class variable.

```ruby
class SomeClass
  @@number_of_cars = 0

  def initialize
    @@number_of_cars += 1
  end

  def self.number_of_cars
    @@number_of_cars
  end
end

p SomeClass.number_of_cars

boleno = SomeClass.new
ciaz = SomeClass.new

p SomeClass.number_of_cars
```

- Constance - They only begin with a capital letter but rubyists prefer to make the entire variable uppercase.
- Creating an instance of a class is creating an object of the class.
- `#to_s`
- Using `#self` inside a class but outside the instance method refers to the class itself.

Example of overriding to_s.

```ruby
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
```

- Inheritance
- Superclass
- DRY - Don't repeat yourself

Example of inheriting a behavior from a superclass.

```ruby
class Animal
  def speak
    "Hello"
  end
end

class GoodDog < Animal
  def speak
    "Arfff!!!"
  end
end

class GoodCat < Animal
end

sparky = GoodDog.new
kitty = GoodCat.new

puts sparky.speak # => Arfff!!!
puts kitty.speak # => Hello
```

- `#super`
- Interface inheritance - Mixin modules

> Objects cannot be created from modules.

- Method access control
- Namespacing

> To instantiate an object of a class contained within a module - `Transportation::Truck.new`
