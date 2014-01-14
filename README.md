---
  tags: user input, cli, looping
  languages: ruby
---

# Build a Jukebox

### Skills: user input, methods, cli, looping

## Instructions

You're going to write a jukebox that introduces itself to the user and then asks for input. 

There are a number of ways to accept user input. As an example, let's build a program that asks a user for their name and says hello to that user using the gets command.

  ```ruby
  def say_hello(name)
    "Hi #{name}!"
  end

  puts "Enter your name:"
  users_name = gets.chomp

  puts say_hello(users_name)
  ```

Your jukebox should respond to 4 commands: help, play, list and exit.

1. The help command should output instructions for the user on how to use the jukebox. Try typing ruby -h for an example of what your output could look like.

2. The list command should output a list of songs that the user can play. There are a number of ways to do this. Be creative. 

3. The play command should accept a song. The user can select either the song number/index or the song name. Once the user has selected the song they want to play, the jukebox should output 'Playing The Phoenix - 1901' or whatever song name is.

4. If the user types in exit, the jukebox should say goodbye and the program should shut down.

Think about the following things:
  * How to keep the program running until the exit command is
executed (Hint: Loop maybe? Loop upon a condition)
  * How to normalize the user's input so LIST and list are the
same. (Hint, maybe downcase and strip it)
  * How to give the songs an "index" so that when you list them
out, you can refer to them by position so the user can just
type play 1 and then you find the first song. (Hint, check
out a method called each_with_index)