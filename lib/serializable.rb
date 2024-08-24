module Serializable
  @@serializer = JSON

  def serialize
    JSON.dump({
      :player_lives => @player_lives,
      :letters_used => @letters_used,
      :secret_word_array => @secret_word_array,
      :secret_word => @secret_word,
      :display_word_array => @display_word_array,
      :display_word => @display_word
    })
  end
  
  def save_game (number)
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    filename = "saved_games/savedgame#{number}.json"
    File.open(filename, 'w') do |file|
      file.puts self.serialize
    end
  end

  def unserialize (string)
    #Add argument to the unserialize method of a number that correlates to 
    #which number of game the user decides they want to play
    obj = @@serializer.parse string

    self.player_lives = obj["player_lives"]
    self.letters_used = obj["letters_used"]
    self.secret_word_array = obj["secret_word_array"]
    self.secret_word = obj["secret_word"]
    self.display_word_array = obj["display_word_array"]
    self.display_word = obj["display_word"]

    puts "\n#{obj["display_word"]}     Lives = #{obj["player_lives"].to_s.colorize(:green)}     Letters used: #{obj["letters_used"].colorize(:red)}"
    self.play(obj["player_lives"], 
    obj["secret_word"], 
    obj["display_word"],
    obj["secret_word_array"], obj["letters_used"])
  end

end