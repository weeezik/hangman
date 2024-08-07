require 'io/console'

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
secret_word = words.sample.chomp #outputs word that is to be used in hangman gameplay
puts secret_word.chars.join(" ")

display_word_array = Array.new(secret_word.length, "_")
puts display_word_array.join(" ")

class Player
  def initialize (lives = 10)
    @lives = lives
  end
  attr :lives
end

player = Player.new
puts "Player lives: #{player.lives}"

letters_used = "Letters used: "

#get player input here
guessed_letter = STDIN.getch.chomp

if secret_word.include?(guessed_letter)
  #put correctly guessed letter into display word anywhere it appears
  puts true
else
  #add incorrectly guessed letter to letters_used
  letters_used << guessed_letter + " "
  puts "Player lives: #{player.lives - 1}"
  puts letters_used
end
