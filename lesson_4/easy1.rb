# Question 1

# Which of the following are objects in Ruby? If they are objects, how can you find out what class they belong to?

true
"hello"
[1, 2, 3, "happy days"]
142

# => All the above mentioned values are objects. You can find out the class they belong to by calling #class on the objects.

true.class
"hello".class
[1, 2, 3, "happy days"].class
142.class

# Question 2

# If we have a Car class and a Truck class and we want to be able to go_fast, how can we add the ability for them to go_fast using the module Speed? How can you check if your Car or Truck can now go fast?

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed

  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed

  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

# => We can call `#ancetors` on the class to check if the Speed module is included in it.

# Question 4

# If we have a class AngryCat how do we create a new instance of this class?

# The AngryCat class might look something like this:

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

new_instance = AngryCat.new
