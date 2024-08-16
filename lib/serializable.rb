module Serializable
  @@serializer = JSON

  # def serialize
  #   obj = {}
  #   instance_variables.map do |var|
  #     obj[var] = instance_variable_get(var)
  #   end
  #   @@serializer.dump obj
  # end
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
  
  def save_game
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    filename = "saved_games/savedgame.json"
    File.open(filename, 'w') do |file|
      file.puts self.serialize
    end
  end

  def unserialize (string)
    obj = @@serializer.parse string
    
    #reassign variables
    self.player_lives = obj["player_lives"]
    self.letters_used = obj["letters_used"]
    self.secret_word_array = obj["secret_word_array"]
    self.secret_word = obj["secret_word"]
    self.display_word_array = obj["display_word_array"]
    self.display_word = obj["display_word"]

    puts "\n#{obj["display_word"]}     Lives = #{obj["player_lives"]}     Letters used: #{obj["letters_used"]}"
    self.play(obj["player_lives"], 
    obj["secret_word"], 
    obj["display_word"],
    obj["secret_word_array"], obj["letters_used"])
  end

end