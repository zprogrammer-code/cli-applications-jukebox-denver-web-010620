# Build a Jukebox

## Objectives

1. Introduce CLI, or Command Line Interface, programs.
2. Running CLI applications.
3. Use `gets` for user input.
4. Introduce stubbing in tests.
5. Integrate procedural Ruby basics to create a simple CLI Jukebox. 
6. Advanced: play music from a Ruby program!

## What is a CLI?

A CLI, or command line interface, allows a user to interface, or interact with, a computer's operating system or a particular application. You've already become comfortable interacting with the command line to navigate files, connect with Github and test your programs. In a command line application, the user will respond to a prompt that your program will output to the terminal. The user's response, or input, will be recieved by the application and the application will then carry out the programmed response based on that input. 

For example, I might have a command line application which, once run, will ask the user for their location and in return ouput the current weather for that location to the terminal.

## Running Command Line Apps

In order to run our program from the command line and allow our user to interact with our program as described above, we need to set up a few things.

First, your program needs a `bin` directory. "Bin" is short for "binary" and is just another way to refer to executable files. Accordingly, your executable files belong in this directory. 

**Executable files** are any files that contain instructions in a form that a computer's operating system or application can understand and follow. Any executable files we place in our bin directory need to begin with the following line: 

`#!/usr/bin/env ruby`

This is often referred to as a "shebang line" and it tells the shell which interpreter to use to execute the remainder of the file. 

Using the above setup, you can run your program by typing `ruby bin/< your file name >` into the command line. 

Alternatively, you can execute your program by simply typing `bin/< your file name >` into the command line, since the shebang line at the top of your executable file is already telling the shell to use Ruby to interpret the rest of the file. 

## Instructions

You're going to write a jukebox that introduces itself to the user and then asks for the user's input on the command line. 

There are a number of ways to accept user input. Today, we'll be building a Jukebox that functions primarily by accepting user input via the command line. 

To demonstrate the example of user input via the command line, let's make a small program inside our `jukebox.rb` file. Our program will ask a user for their name, collect the user input via the `gets` command, and then say hello to that user. Let's follow the code block below:

```ruby
def say_hello(name)
  "Hi #{name}!"
end

puts "Enter your name:"
users_name = gets.chomp

puts say_hello(users_name)
```

When we run `ruby jukebox.rb`, it's going to print out `Enter your name:`, then the Terminal prompt will return, and you'll type in your name. The user input is obtained by the `gets` method, then any trailing whitespace gets removed via the `chomp` method, and finally the result is stored in the `users_name` local variable (let's assume `users_name = "Avi Flombaum"`). Finally, the program will print out the output of the `say_hello` method, which is `"Hi, Avi Flombaum!"`.

Now let's move on to the Jukebox.

![Jukebox](https://camo.githubusercontent.com/fcdfb7f86db18e9a497747c8d6f4283a8a136f76/687474703a2f2f646c2e64726f70626f7875736572636f6e74656e742e636f6d2f732f6f7764666a69356c6a71756264686e2f323031342d30312d3239253230617425323031312e3130253230414d2e706e67)

Your jukebox should respond to 4 commands: `help`, `play`, `list`, and `exit`.

1. The help command should output instructions for the user on how to use the jukebox. This should call a method named `help`. Try typing ruby -h for an example of what your output could look like.

2. The list command should output a list of songs that the user can play. It should call a method named `list`. 

3. The play command should accept a song. It should call a `play` method. The user can select either the song number/index or the song name. Once the user has selected the song they want to play, the jukebox should output 'Playing Phoenix - 1901' or whatever the song name is.

4. If the user types in exit, the jukebox should say goodbye and the program should shut down.

Think about the following things:

* How to keep the program running until the exit command is
executed (Hint: Loop maybe? Loop upon a condition?)
* How to normalize the user's input so LIST and list are the
same. (Hint, maybe `downcase` and `strip` it).
* How to give the songs an "index" so that when you list them
out, you can refer to them by position so the user can just
type play 1 and then you find the first song. (Hint, check
out a method called `each_with_index`).

### Bonus:

Once you get the tests to pass, get creative! Make the Jukebox your own. For example, you could make your script pop open the [youtube video](https://github.com/grosser/youtube_search) for the song. You could parse the [Spotify Popular Track JSON](http://charts.spotify.com/api/tracks/most_streamed/global/daily/latest) and populate your jukebox from that data.

## Running Your Jukebox 

Packaged with this repository is a runner file `bin/jukebox`.

The executable "bin/jukebox" is a Ruby file, but the ".rb" extension has
been left off. The ".rb" extension is not mandatory for Ruby files, it
is just a nice thing to have for the purposes of identifying the type of
the file. However, it is a convention to leave the file extension off of
executable files, which comes from true binary files that contain pure
machine code (1's and 0's) rather than human readable source code like
Ruby.

Assuming you are in the root directory of the jukebox project, run your 
jukebox from the command line with `ruby bin/jukebox` or simply 
`bin/jukebox` (thanks to our shebang line).

## Testing Your Jukebox

You already know that your Jukebox command line application relies on a user's input to run. In order to test our application programmatically––in other words, test it without having to run and interact with the program ourselves––we will rely on stubbing in our test suite. 

## What is Stubbing?

Stubbing refers to the fake implementation of a method. In the context of this test suite, we will stub the `gets` method call that our program relies on to obtain user input and feed it back into the application. In this way, we can simulate the CLI and effectively test our app. 

Let's compare the regular running of our Jukebox––i.e., when a real live human interacts with it––with the testing of our Jukebox. We'll do this by taking a closer look at the `play` method. 

Without giving away *all* of the implementation of this method and spoiling your fun, we can imagine that our `play` method might ask the user what song they want to hear, store that input using the `gets` method and use it to determine what song to play.  

Remember, the `gets` method lets the user input a line and returns that line to your program. In our test suite, we need to fake this interaction and we'll use stubbing to do it. Check out the following line from our `jukebox_spec.rb`:  

```ruby
it "can use a full song name to find a song" do
  allow(self).to receive(:gets).and_return("Phoenix - 1901")
  expect{ play(songs) }.to output(/Phoenix - 1901/).to_stdout
end
```
 
      
Let's break down what's happening above: 

With `allow(self).to receive(:gets).and_return("Phoenix - 1901")`,
we are faking a call to the `gets` method and telling it to return a value of `"Phoenix - 1901"`. 

Now, when we call the `play` method on the following line, it has a `gets` value to operate on. 

Then, we test the output of the `play` method with
 `expect{ play(songs) }.to output(/Phoenix - 1901/).to_stdout`

This line uses one of Learn's output matchers. 

### Output Matchers 

Learn's output matchers provide a way to check that your program has emitted output to `$stdout`––a global variable that keeps track of the current standard output to your terminal. Don't worry too much about global variables right now, just know that they can be accessed from anywhere in your program. 

The `.to_stdout` method works by temporarily replacing the `$stdout` variable. When the `output` method is used with a string or a regex (as above), your test will pass if the block outputs a string `to_stdout` that matches the given string or regex.

So, these lines of our test suite:

```ruby
allow(self).to receive(:gets).and_return("Phoenix - 1901")
expect{ play(songs) }.to output(/Phoenix - 1901/).to_stdout
```

Accomplish the following:

1. Establish a `gets` value for the `play` method to utilize
2. Execute the `play` method contained in the block 
2. Check to see if the `play` method outputs content that matches the regular expression `/Phoenix - 1901/`

## Advanced: Playing Music from Ruby

In `lib/advanced_jukebox.rb` you'll be building on your jukebox so that it allows the use to play songs from the command line. You'll be playing the songs in `audio/Emerald-Park`, which contains some mp3 files. 

### Setting Up the Songs Hash

In `lib/advanced_jukebox.rb` you'll see a `my_songs` hash which has keys of song names and values of the path to of each mp3 file (in `jukebox-cli/audio/Emerald-Park/<file name>.mp3`). 

Change the value of each hash key so reflect the correct file path. For example, if this jukebox-cli directory is in `Users/<your name>/Desktop/Dev/`, the value of the first key should be `Users/<your name>/Desktop/Dev/jukebox-cli/audio/Emerald-Park/01.mp3`. If you're not sure what the path to the file is, cd into the directory of this lab in your terminal and type `pwd`. This stands for "print working directory" and will return the path to your current location. 

### How can a Ruby program play music?

It is possible to play audio files via the command line by simply typing `open <path to audio file>`. This will launch your computer's audio player (iTunes, for example). In order to tell Ruby to execute a command line command, we use the following syntax: 

```ruby
system 'open <path to audio file'
```

This is the code that you'll be adding to your `play` method in order to play the audio files we've provided for you. 

### Coding `advanced_jukebox.rb`

Check out the code in `advanced_jukebox.rb`, we've left the method definitions for you and provided you the song hash, `my_songs`. 

Follow the instructions in the commends of `advanced_jukebox.rb` to get your jukebox working. This is a bonus challenge, so there are not tests. Just get your jukebox playing music.  
