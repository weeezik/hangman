require_relative 'lib/game'

dictionary = File.new("google-10000-english-no-swears.txt", "r")
hangman = Game.new(dictionary)

puts hangman.secret_word

hangman.display
puts "\nPress any letter to guess! Press the enter key at any point to save the game"

hangman.play(hangman.player_lives, hangman.secret_word, 
hangman.display_word, hangman.secret_word_array)
