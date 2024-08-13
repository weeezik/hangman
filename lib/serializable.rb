module Serializable
  @@serializer = JSON

  def serialize
    obj = {}
    instance_variables.map do |var|
      obj[var] = instance_variable_get(var)
    end
    @@serializer.dump obj
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
    puts "\n#{obj["@display_word"]}     Lives = #{obj["@player_lives"]}     Letters used: #{obj["@letters_used"]}"
 
    self.play(obj["@player_lives"], 
    obj["@secret_word"], 
    obj["@display_word"],
    obj["@secret_word_array"])
  end

end