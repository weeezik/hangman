require_relative 'lib/game'

dictionary = File.new("google-10000-english-no-swears.txt", "r")
hangman = Game.new(dictionary)

puts hangman.secret_word #turn on/off to show answer
hangman.display #starting display
hangman.play(hangman.player_lives, hangman.secret_word, #gameplay
hangman.display_word, hangman.secret_word_array)

#save functionality
  #hangman.to_json
  #hangman.save