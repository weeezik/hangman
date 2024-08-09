require 'io/console'
require 'colorize'

require_relative 'lib/clean_dictionary'
require_relative 'lib/generate_secret_word'
require_relative 'lib/correct_letter_substitution'
require_relative 'lib/determine_end_display'
require_relative 'lib/game'

dictionary = File.new("google-10000-english-no-swears.txt", "r")
secret_word_array = generate_secret_word(dictionary)
secret_word = secret_word_array.chars.join(" ")
puts secret_word

display_word_array = Array.new(secret_word_array.length, "_")
display_word = display_word_array.join(" ")

player_lives = 10
letters_used = ""

puts "\n#{display_word}     Lives = #{player_lives}    Letters used: #{letters_used}"
puts "\nPress any letter to guess! Press the enter key at any point to save the game"

until player_lives == 0 || secret_word == display_word do
  guessed_letter = STDIN.getch.downcase.chomp

  if secret_word.include?(guessed_letter)
    correct_letter_substitution(secret_word, guessed_letter, display_word)
    puts "\n#{display_word}     Lives = #{player_lives}    Letters used: #{letters_used}"
  else
    if letters_used.include?(guessed_letter)
      puts "\n#{guessed_letter} was already guessed..."
      puts "\n#{display_word}     Lives = #{player_lives}     Letters used: #{letters_used}"
    else
      letters_used << guessed_letter + " "
      player_lives -= 1
      puts "\n#{display_word}     Lives = #{player_lives}     Letters used: #{letters_used}"
    end
  end

end

determine_end_display(player_lives, secret_word_array)
