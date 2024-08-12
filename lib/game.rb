require 'io/console'
require 'colorize'
require 'json'

require_relative 'clean_dictionary'
require_relative 'substitutable'

class Game
  include Substitutable
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

  def determine_end_display (lives, secret_word)
    if lives == 0
      puts "\nYou ran out of lives 😖😖😖😖😖".colorize(:red)
      puts "The word was #{secret_word}\n"
    else
      puts "\nNice job! You win! 😁😁😁\n".colorize(:green).blink
    end
  end

  def display
    puts "\n#{@display_word}     Lives = #{@player_lives}    Letters used: #{@letters_used}"
    puts "\nPress any letter to guess! Press the enter key at any point to save the game"
  end

  def play (player_lives, secret_word, display_word, secret_word_array)
    until player_lives == 0 || secret_word == display_word do
      guessed_letter = STDIN.getch.downcase.chomp
      if guessed_letter == "1"
        self.save_game
        #save game and exit script
      end
      if secret_word.include?(guessed_letter)
        correct_letter_substitution(secret_word, guessed_letter, display_word)
        puts "\n#{display_word}     Lives = #{player_lives}     Letters used: #{letters_used}"
      else
        if letters_used.include?(guessed_letter)
          puts "\n#{guessed_letter} was already guessed..."
          puts "\n#{display_word}     Lives = #{player_lives}     Letters used: #{letters_used}"
        else
          letters_used << guessed_letter.colorize(:red) + " "
          player_lives -= 1
          puts "\n#{display_word}     Lives = #{player_lives}     Letters used: #{letters_used}"
        end
      end
    end
    self.determine_end_display(player_lives, secret_word_array)
  end

  def to_json
    JSON.dump ({
      :secret_word => @secret_word,
      :display_word => @display_word,
      :player_lives => @player_lives,
      :letters_used => @letters_used
    })  
  end

  def save_game
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    filename = "saved_games/game1save.json"
    File.open(filename, 'w') do |file|
      file.puts self.to_json
    end
  end

  def self.from_json (string)
    data = JSON.load string
    p data
  end

end

# dictionary = File.new("google-10000-english-no-swears.txt", "r")

# game_object = Game.new(dictionary)
# puts game_object.to_json
# Game.from_json(game_object.to_json)




