require_relative 'clean_dictionary'
dictionary = File.new("google-10000-english-no-swears.txt", "r")

class Game
  def initialize(dictionary)
    @player_lives = 10
    @letters_used = ""

    @secret_word_array = generate_secret_word(dictionary)
    @secret_word = secret_word_array.chars.join(" ")

    @display_word_array = Array.new(@secret_word_array.length, "_")
    @display_word = @display_word_array.join(" ")
  end

  attr_accessor :player_lives, :letters_used, :secret_word_array, 
  :secret_word, :display_word_array, :display_word

  def generate_secret_word(dictionary)
    words = dictionary.readlines
    clean_dictionary(words)
    secret_word_array = words.sample.chomp
    secret_word_array
  end

  def display
    puts "\n#{display_word}     Lives = #{player_lives}    Letters used: #{letters_used}"
  end

end

hangman = Game.new(dictionary)

p hangman.secret_word