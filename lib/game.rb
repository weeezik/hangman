require 'io/console'
require 'colorize'
require 'json'

require_relative 'clean_dictionary'
require_relative 'substitutable'
require_relative 'serializable'
require_relative 'iterable'

class Game
  include Substitutable
  include Serializable
  include Iterable

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
      puts nil
    end
  end

  def display
    puts "\n#{@display_word}     Lives = #{@player_lives.to_s.colorize(:green)}    Letters used: #{@letters_used}"
    puts "\nPress any letter to guess!\nPress 1 at any point to save the game.\nPress 0 to load a saved game."
  end

  def play (player_lives, secret_word, display_word, secret_word_array, letters_used)
    until player_lives == 0 || secret_word == display_word do
      guessed_letter = STDIN.getch.downcase.chomp
      #load a saved game
      if guessed_letter == "0"
        # Load Game Selection
        #   1. show user possible games to play with the current display word showing
        #   and game number
        #   2. allow user to select the game they would like to play
        #   3. when game is selected identify it's file name and assign that file
        #   to be the json_file variable
        write_iterator_file
        json_file = File.open("saved_games/savedgame#{$iterator}.json",'r')
        while line = json_file.gets do
          serialized_string = line
        end
        self.unserialize(serialized_string)
        break
      end
      #save game
      if guessed_letter == "1"
        iterate_iterator_file
        self.save_game($iterator)
        puts "Your game has been saved.\n"
        break
      end
      if secret_word.include?(guessed_letter)
        correct_letter_substitution(secret_word, guessed_letter, display_word)
        self.display_word = display_word
        puts "\n#{display_word}     Lives = #{player_lives.to_s.colorize(:green)}     Letters used: #{letters_used.colorize(:red)}"
      else
        if letters_used.include?(guessed_letter)
          puts "\n#{guessed_letter} was already guessed..."
          self.display_word = display_word
          puts "\n#{display_word}     Lives = #{player_lives.to_s.colorize(:green)}     Letters used: #{letters_used.colorize(:red)}"
        else
          letters_used << guessed_letter + " "
          self.player_lives = player_lives -= 1
          self.display_word = display_word
          puts "\n#{display_word}     Lives = #{player_lives.to_s.colorize(:green)}     Letters used: #{letters_used.colorize(:red)}"
        end
      end
      self.determine_end_display(player_lives, secret_word, display_word)
    end
  end
  
end




