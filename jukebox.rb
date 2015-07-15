
require 'pry'
my_songs = {
"Go Go GO" => 'Users/sophiedebenedetto/Desktop/Emerald-Park/01.mp3',
"LiberTeens" => 'Users/sophiedebenedetto/Desktop/Emerald-Park/02.mp3',
"Hamburg" =>  'Users/sophiedebenedetto/Desktop/Emerald-Park/03.mp3',
"Guiding Light" => 'Users/sophiedebenedetto/Desktop/Emerald-Park/04.mp3',
"Wolf" => 'Users/sophiedebenedetto/Desktop/Emerald-Park/05.mp3',
"Blue" => 'Users/sophiedebenedetto/Desktop/Emerald-Park/06.mp3',
"Graduation Failed" => 'Users/sophiedebenedetto/Desktop/Emerald-Park/07.mp3'
}

def help
  help = <<-HELP
I accept the following commands:
- help : displays this help message
- list : displays a list of songs you can play
- play : lets you choose a song to play
- exit : exits this program
HELP

  puts help
end



def list(my_songs)
  # binding.pry
  my_songs.keys.each_with_index do |song, i|
    puts "#{i + 1}. #{song}"
  end
end


def play(my_songs)
  puts "Please enter a song name"
  song_to_play = gets.chomp
  if !my_songs.keys.include?(song_to_play)
    puts "Invalid input, please try again"
  else
    puts "Now playing #{song_to_play}"
    system 'open ' << my_songs[song_to_play]
  end
end

def exit_jukebox
  puts "Goodbye"
end

def run(my_songs)
  help

  input = ""
  while input
    puts "Please enter a command:"
    input = gets.downcase.strip
    case input
    when 'list'
      list(my_songs)
    when 'play'
      list(my_songs)
      play(my_songs)
    when 'help'
      help
    when 'exit'
      exit_jukebox
      break
    else
      help
    end
  end
end
