# Sometimes, unfortunately, our programs must interact
# with users. Programs can receive input through a variety
# of interfaces.

# Let's build a program that asks a user for their name and
# says hello to that user.

# def assert_equals(expected, actual)
#   if !(expected == actual)
#     puts "fail: expected #{expected}, got #{actual}"
#   end
# end

def say_hello(name)
  "Hi #{name}!"
end

puts "Enter your name:"
users_name = gets.chomp

puts say_hello(users_name)
