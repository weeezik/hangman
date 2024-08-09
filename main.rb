require 'io/console'
require 'colorize'

require_relative 'lib/clean_dictionary'
require_relative 'lib/generate_secret_word'
require_relative 'lib/correct_letter_substitution'

dictionary = File.new("google-10000-english-no-swears.txt", "r")
secret_word_array = generate_secret_word(dictionary)
secret_word = secret_word_array.chars.join(" ")
puts secret_word

display_word_array = Array.new(secret_word_array.length, "_")
display_word = display_word_array.join(" ")

player_lives = 10
letters_used = ""

puts "\n#{display_word}     Lives = #{player_lives}    Letters used: #{letters_used}"
puts "\nPress any letter to guess!"

until player_lives == 0 || secret_word == display_word do
  guessed_letter = STDIN.getch.downcase.chomp

  if secret_word.include?(guessed_letter)
    #put correctly guessed letter into display word anywhere it appears
    locations_of_letters = identify_locations_of_letter(secret_word, guessed_letter)
    replace_letters(guessed_letter, display_word, locations_of_letters)
    puts "\n#{display_word}     Lives = #{player_lives}    Letters used: #{letters_used}"
  else
    #add incorrectly guessed letter to letters_used
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

if player_lives == 0
  puts "\nYou ran out of lives 😖😖😖😖😖\n".colorize(:red)
  puts "The word was #{secret_word_array}\n"
else
  puts "\nNice job! You win! 😁😁😁\n".colorize(:green).blink
end
