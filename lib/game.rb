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
      puts nil
    end
  end

  def display
    puts "\n#{@display_word}     Lives = #{@player_lives}    Letters used: #{@letters_used}"
    puts "\nPress any letter to guess!\nPress 1 at any point to save the game.\nPress 0 to load a saved game."
  end

  def play (player_lives, secret_word, display_word, secret_word_array, letters_used)
    until player_lives == 0 || secret_word == display_word do
      guessed_letter = STDIN.getch.downcase.chomp
      #load a saved game
      if guessed_letter == "0"
        json_file = File.new('saved_games/savedgame.json','r')
        while line = json_file.gets do
          serialized_string = line
        end
        self.unserialize(serialized_string)
        break
      end
      #save game
      if guessed_letter == "1"
        self.save_game
        puts "Your game has been saved."
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
      self.determine_end_display(player_lives, secret_word, display_word)
    end
  end
  
end




