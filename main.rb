require_relative 'lib/game'

dictionary = File.new("google-10000-english-no-swears.txt", "r")
hangman = Game.new(dictionary)

File.open('iterator.txt', 'r') do |file|
  $iterator = file.read.to_i
  $iterator += 1
end
# puts hangman.secret_word #turn on/off to show answer
hangman.display #starting display
#hangman.choose_game_method (gives player the opportunity to 
#select a specific saved game)
hangman.play(hangman.player_lives, hangman.secret_word, #gameplay
hangman.display_word, hangman.secret_word_array, hangman.letters_used)

File.open('iterator.txt', 'w') { |file| file.write($iterator.to_s) }




