class Person
  attr_accessor :name # => Read and Write access

  def initialize(name)
    @name = name
  end

  def greeting
    puts "Hi, my name is #{name}"
  end
end


class Student < Person
  def learn
    puts "I get it!"
  end
end

class Instructor < Person
  def teach
    puts "Everything in Ruby is an Object"

  end
end

chris = Instructor.new("Chris")
chris.greeting
cristina = Student.new("Cristina")
cristina.greeting

chris.teach
cristina.learn
#cristina.teach
# NoMethodError came up
# It doesn't work because teach is not an instance method of Student class
# or the superclass of it.
