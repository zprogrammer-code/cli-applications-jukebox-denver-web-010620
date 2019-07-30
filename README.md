# Build a Jukebox

## Learning Goals

- Implement multiple methods that work together
- Handle user input with conditional logic
- Read and use information in an array
- Create an application that persists until the user decides to exit

## Introduction

In this lesson, your task is to write a jukebox application that introduces
itself to the user and then asks for the user's input on the command line.

To quickly review user input via the command line, let's make a small program.
Inside the `jukebox.rb` file (within the `lib` subfolder), we see an array of
song titles:

```ruby
songs = [
  "Phoenix - 1901",
  "Tokyo Police Club - Wait Up",
  "Sufjan Stevens - Too Much",
  "The Naked and the Famous - Young Blood",
  "(Far From) Home - Tiga",
  "The Cults - Abducted",
  "Phoenix - Consolation Prizes",
  "Harry Chapin - Cats in the Cradle",
  "Amos Lee - Keep It Loose, Keep It Tight"
]
```

Leave this for now. Below it, we're going to build a program that asks for a
user's name, then greets the user. Add the following to `jukebox.rb`:

```ruby
def say_hello(name)
  "Hi #{name}!"
end

puts "Enter your name:"
users_name = gets.strip

puts say_hello(users_name)
```

When we run `ruby lib/jukebox.rb`, it's going to print out `Enter your name:`.
Then, the terminal prompt will return to a new line, and you'll type in your
name.

The user input is obtained by the `gets` method. However, the input captured can
include things we don't want such as whitespace before or after the input user
name. The input also includes the 'carriage return' characters - after you have
entered your name, you must press `Enter` / `Return` to continue, which adds
`\n` to the end of the input.

To remove the carriage return characters and any added whitespace, we can use
the  `strip` method. `strip` will remove these things for us and leave just the
text we need.

The result is stored in the `users_name` local variable. If we imagine
entering "Avi Flombaum" when the application prompts us, the program will print
out the output of the `say_hello` method, which is `"Hi, Avi Flombaum!"`.

## Instructions

Now, go ahead and delete or comment out the code we just wrote. That was just for
practice (and fun). Let's move on to the Jukebox. When completed, using the
Jukebox will look something like this:

![Jukebox](https://curriculum-content.s3.amazonaws.com/prework/jukebox_01.png)

The Jukebox application will respond to four commands, `help`, `play`, `list`, and
`exit`. When you run the program in the command line it should greet the user
and prompt them to choose one of these commands.

- The `help` command should output instructions for the user on how to use the
  jukebox.
- The `list` command should output a list of songs that the user can play.
- The `play` command should ask a user to input a song name _or_ track number.
  It should then output the appropriate song name.
- If the user types `exit`, the jukebox should say goodbye and the program
  should shut down.

Let's take a closer look at the methods we'll need to build to get our
Jukebox up and running as described here.

### Separating Concerns Into Methods

We'll be building a series of methods that enact the desired behavior of our
Jukebox. As we saw above, we have four commands that do different things in our
application. To make our code easier to understand and more flexible, it's best
that we separate these commands into individual methods. Each method would then
be handling a particular _concern_ of our application: printing out helpful
info, listing songs, "playing" a particular song, or stopping the program.

In `lib/jukebox.rb` we'll create `help`, `play`, `list` and `exit_jukebox`
methods. Then, we'll also need to build a `run` method that calls on all of
these "helper" methods to implement the behavior of our program.

The executable file, `bin/jukebox`, is already set up to call the `run` method
that we define in `lib/jukebox.rb`.

### Identifying Data We Will Work With

Open up `lib/jukebox.rb` and you should see this:

```ruby
songs = [
  "Phoenix - 1901",
  "Tokyo Police Club - Wait Up",
  "Sufjan Stevens - Too Much",
  "The Naked and the Famous - Young Blood",
  "(Far From) Home - Tiga",
  "The Cults - Abducted",
  "Phoenix - Consolation Prizes",
  "Harry Chapin - Cats in the Cradle",
  "Amos Lee - Keep It Loose, Keep It Tight"
]
```

If you don't see the above array, or if you accidentally deleted or modified the
list, copy and paste the code snippet into `lib/jukebox.rb` before continuing.
This array is the list of songs that our jukebox will be working with. The
methods we will write will operate on this array of songs.

### The `help` Method

This method should `puts` out the following:

```bash
I accept the following commands:
- help : displays this help message
- list : displays a list of songs you can play
- play : lets you choose a song to play
- exit : exits this program
```

Remember that a `puts` will be needed for _each_ new line of output.

### The `list` Method

This method takes in an argument of the `songs` array and outputs each song in
the array on a new line. A number should be listed before each song, indicating
that songs track number:

```bash
1. Phoenix - 1901
2. Tokyo Police Club - Wait Up
3. Sufjan Stevens - Too Much
4. The Naked and the Famous - Young Blood
5. (Far From) Home - Tiga
6. The Cults - Abducted
7. Phoenix - Consolation Prizes
8. Harry Chapin - Cats in the Cradle
9. Amos Lee - Keep It Loose, Keep It Tight
```

**Hint:** Use the [`Array#each_with_index`][each_with] method to access the
index number of a given element as you step through the iteration. Remember that
arrays are indexed starting at `0`. So, adding `1` to the index number at a
given step of the iteration will result in the correct song number for the
purposes of outputting your list of songs.

### The `play` Method

This method also takes in an argument of the `songs` array. It first `puts` out
the prompt: `"Please enter a song name or number:"`. It then stores the user's
response using `gets.strip`.

If the user's response is a valid song number or song name, the method should
`puts` out: `"Playing <song name>"`. Otherwise, it should `puts` out:
`"Invalid input, please try again"`.

### The `exit_jukebox` Method

This method is simple. It `puts` out: `"Goodbye"`.

### The `run` Method

This method is a little trickier. It is where we pull together all of our other
methods into a functioning program.

First, this method should call on the `help` method to show the user the
available commands.

Second, it should `puts` out the prompt: `"Please enter a command:"`. Just like
`play`, we will need to capture user input using `gets` and [`strip`][strip]
(you can also use [`chomp`][chomp], but this will only remove carriage return
characters, not extra whitespaces).

Third, the `run` method will need to call one of the four methods we've written,
based on the user input. For example, if the input is `"exit"`, we would want to
call the `exit_jukebox` method.

Now here is the tricky part. We've provided a way for a user to exit the program
because ideally, we actually want the program to run until the _user_ decides to
exit. We need a way to keep our program running as long as the user's input is
_not_ `"exit"`. For this, we can use a loop!

A loop can be used to contain the process of capturing user input then deciding
what to do with it. If this is contained within a loop, as long as the loop
conditions are met, the user will be able to enter commands over and over.

Use `if` or `case` statements to determine how your program will respond to a
user's input. For example, if their input is `"list"`, call the `list` method
if their input is `"play"`, call the `play` method if their input is `"help"`,
call the `help` method and if their input is `"exit"`, call the `exit_jukebox`
method _and_ break out of your loop to stop the program.

Part of the difficulty in working with loops is that its easy to get stuck in an
infinite loop. We recommend working out the code for _exiting_ the loop first.
Some of the tests in this lab also rely on the ability to exit to finish
testing, so it is possible for your tests to hang half way through.

## Testing Your Code

You already know that your Jukebox command-line application relies on a user's
input to run. In order to test our application programmatically –– in other
words, test it without having to run and interact with the program ourselves ––
we use something called [stubbing][stub] that allows us to fake the output of
built-in methods such as `gets`.

## Running Your Jukebox

Packaged with this repository is a file `bin/jukebox`. This is a Ruby file,
but the `.rb` has been left off to indicate that this file is meant as an
executable. It isn't quite the same thing as a file of compiled machine code
(it still requires the Ruby interpreter to run) but is treated similarly as
the file a user would run when they want to run our program.

Open up `bin/jukebox` and you will see the following:

```ruby
#!/usr/bin/env ruby

require_relative "../lib/jukebox"

songs = [
  "Phoenix - 1901",
  "Tokyo Police Club - Wait Up",
  "Sufjan Stevens - Too Much",
  "The Naked and the Famous - Young Blood",
  "(Far From) Home - Tiga",
  "The Cults - Abducted",
  "Phoenix - Consolation Prizes",
  "Harry Chapin - Cats in the Cradle",
  "Amos Lee - Keep It Loose, Keep It Tight"
]

run(songs)
```

The purpose of this file is to set up the proper environment for our code to
work in.

First, we require the `lib` file in which we defined our code. By requiring it,
this executable file now has access to all of the methods we defined in
`lib/jukebox.rb`.

Second, we have our `songs` array.

Third, we call `run(songs)`, the method we defined to enact the behavior of our
program.

Assuming you are in the root directory of the jukebox project, run your jukebox
from the command line with `ruby bin/jukebox` or simply `bin/jukebox` (thanks to
the [shebang line][shebang] at the top of the file).

## Conclusion

We've moved from building a single method CLI application to an app with five
methods and looping, enabling us to navigate around our application and interact
with it repeatedly.

## Resources

- [Control Expressions and Loops][loops]

[loops]: https://ruby-doc.org/core-2.5.0/doc/syntax/control_expressions_rdoc.html
[each_with]: https://ruby-doc.org/core-2.6.2/Enumerable.html#method-i-each_with_index
[chomp]: https://ruby-doc.org/core-2.5.0/String.html#method-i-chomp
[strip]: https://ruby-doc.org/core-2.5.0/String.html#method-i-strip
[shebang]: https://en.wikipedia.org/wiki/Shebang_(Unix)
[stub]: https://relishapp.com/rspec/rspec-mocks/v/3-8/docs

<p class='util--hide'>View <a href='https://learn.co/lessons/jukebox-cli'>Jukebox CLI</a> on Learn.co and start learning to code for free.</p>
