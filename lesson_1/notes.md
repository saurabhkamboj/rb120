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
