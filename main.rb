require 'io/console'
require 'colorize'

def clean_dictionary (dictionary)
  dictionary.each do |word|
    word.delete("\n")
  end

  dictionary.filter! do |word|
    word.length > 5
  end
  dictionary.filter! do |word|
    word.length < 12
  end
end

dictionary = File.new("google-10000-english-no-swears.txt", "r")
words = dictionary.readlines
clean_dictionary(words)
secret_word_array = words.sample.chomp
secret_word = secret_word_array.chars.join(" ")
puts secret_word

display_word_array = Array.new(secret_word_array.length, "_")
display_word = display_word_array.join(" ")

player_lives = 10
letters_used = ""

def identify_locations_of_letter(word, letter)
  location_and_letter = word.each_char.with_index.select do |char,idx|
    char == letter
  end
  # location_array = location_and_letter.select {|item| item.is_a? String}
  location_array = location_and_letter.flatten!.select {|item| item.is_a?(Integer)}
  location_array
end
def replace_letters (letter, display_word, positions)
  positions.each do |position|
    display_word[position] = letter
  end
  display_word
end


puts "\n#{display_word}     Lives = #{player_lives}    Letters used: #{letters_used}"
puts "\nPress a letter to guess!"

until player_lives == 0 || secret_word == display_word do
  #get player input here
  guessed_letter = STDIN.getch.chomp
  if secret_word.include?(guessed_letter)
    #put correctly guessed letter into display word anywhere it appears
    locations_of_letters = identify_locations_of_letter(secret_word, guessed_letter)
    replace_letters(guessed_letter, display_word, locations_of_letters)
    puts "\n#{display_word}     Lives = #{player_lives}    Letters used: #{letters_used}"
  else
    #add incorrectly guessed letter to letters_used
    if letters_used.include?(guessed_letter)
      puts "\nThat letter was already guessed, try again."
      puts "\n#{display_word}     Lives = #{player_lives}     Letters used: #{letters_used}"
    else
      letters_used << guessed_letter + " "
      player_lives -= 1
      puts "\n#{display_word}     Lives = #{player_lives}     Letters used: #{letters_used}"
    end
  end
end

if player_lives == 0
  puts "\nYou ran out of lives 
  😖😖😖😖😖\n".colorize(:red)
  puts "The word was #{secret_word_array}\n"
else
  puts "\nNice job! You win! 😁😁😁\n".colorize(:green).blink
end
