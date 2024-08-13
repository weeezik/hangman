require 'io/console'
require 'colorize'
require 'json'

require_relative 'clean_dictionary'
require_relative 'substitutable'
require_relative 'serializable'

class Game
  include Substitutable
  include Serializable

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

  def determine_end_display (lives, secret_word, display_word)
    if lives == 0
      puts "\nYou ran out of lives 😖😖😖😖😖".colorize(:red)
      puts "The word was #{secret_word}\n"
    elsif secret_word == display_word
      puts "\nNice job! You win! 😁😁😁\n".colorize(:green).blink
    else
      puts "Game has been saved."
    end
  end

  def display
    puts "\n#{@display_word}     Lives = #{@player_lives}    Letters used: #{@letters_used}"
    puts "\nPress any letter to guess! Press 0 to load a saved game.
    Press 1 at any point to save the game"
  end

  def play (player_lives, secret_word, display_word, secret_word_array)
    until player_lives == 0 || secret_word == display_word do
      guessed_letter = STDIN.getch.downcase.chomp
      #load a saved game
      # if guessed_letter == "0"
      #   self.from_json
      # end
      #save game
      if guessed_letter == "1"
        self.save_game
        #save game and exit script
        break
      end
      if secret_word.include?(guessed_letter)
        correct_letter_substitution(secret_word, guessed_letter, display_word)
        self.display_word = display_word
        puts "\n#{display_word}     Lives = #{player_lives}     Letters used: #{letters_used}"
      else
        if letters_used.include?(guessed_letter)
          puts "\n#{guessed_letter} was already guessed..."
          self.display_word = display_word
          puts "\n#{display_word}     Lives = #{player_lives}     Letters used: #{letters_used}"
        else
          letters_used << guessed_letter.colorize(:red) + " "
          self.player_lives = player_lives -= 1
          self.display_word = display_word
          puts "\n#{display_word}     Lives = #{player_lives}     Letters used: #{letters_used}"
        end
      end
    end
    self.determine_end_display(player_lives, secret_word, display_word)
  end

  # def self.from_json (string, game_object)
  #   data = JSON.load string
  #   game_object.display
  #   game_object.play(data['player_lives'],data['secret_word'],
  #   data['display_word'],data['secret_word_array'])
  # end

end




