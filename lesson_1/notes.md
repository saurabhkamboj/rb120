# RB120 notes

- Encapsulation
- Polymorphism
- Inheritance
- Superclass
- Class
- Module
- Mixin

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

- Constructor
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
