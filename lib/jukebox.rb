require 'pry'
def help 
puts "I accept the following commands:"
puts  "- help : displays this help message" 
puts "- list : displays a list of songs you can play"
puts "- play : lets you choose a song to play"
puts "- exit : exits this program"
end
def play(songs)
  puts "Please enter a song name or number:"
 if  songs = gets.strip
   puts songs
end
  if songs != gets.strip
   puts "Invalid input, please try again"
 end
 if songs = gets.strip
 puts "Phoenix - 1901"
end
end
#list 
#exit