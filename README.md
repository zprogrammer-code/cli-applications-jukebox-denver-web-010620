---
  tags: user input, cli, looping, gets
  languages: ruby
resources: 3
---

# Build a Jukebox

### Skills: user input, methods, cli, looping, gets

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

1. The help command should output instructions for the user on how to use the jukebox. This should call a method named `help`. Try typing ruby -h for an example of what your output could look like.

2. The list command should output a list of songs that the user can play. It should call a method named `list`. 

3. The play command should accept a song. It should call a `play` method. The user can select either the song number/index or the song name. Once the user has selected the song they want to play, the jukebox should output 'Playing Phoenix - 1901' or whatever the song name is.

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

Bonus:
  * Once you get the tests to pass, get creative! Make the Jukebox your own. You could, for example, actually make the songs play.

## Running Your Jukebox 

Packaged with this repository is a runner file "bin/jukebox".

The "bin" directory is short for "binary", which is another way of referrering to an executable file.

The executable "bin/jukebox" is a Ruby file, but the ".rb" extension has
been left off. The ".rb" extension is not mandatory for Ruby files, it
is just a nice thing to have for the purposes of identifying the type of
the file. However, it is a convention to leave the file extension off of
executable files, which comes from true binary files that contain pure
machine code (1's and 0's) rather than human readable source code like
Ruby.

Assuming you are in the root directory of the jukebox project, run your jukebox from the command line with `ruby bin/jukebox`.

Alternatively, you can also just say `bin/jukebox` since a line of
code has been added to the top of the bin/jukebox runner file that tells
your command line shell which program to run the file with.

## Resources
* [Learn to Program](http://books.flatironschool.com/books/43) - [7.3 Looping](http://books.flatironschool.com/books/43), page 54
* [Learn to Program](http://books.flatironschool.com/books/43) - [5.3 The gets Method](http://books.flatironschool.com/books/43), page 36
* [Learn to Program](http://books.flatironschool.com/books/43) - [5.5 The chomp Method](http://books.flatironschool.com/books/43), page 37
