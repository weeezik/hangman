module Serializable
  @@serializer = JSON
  
  def serialize
    @@serializer.dump ({
      :secret_word => @secret_word,
      :display_word => @display_word,
      :player_lives => @player_lives,
      :letters_used => @letters_used,
      :secret_word_array => @secret_word_array
    })  
  end

  def save_game
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    filename = "saved_games/savedgame#{guessed_letter}.json"
    File.open(filename, 'w') do |file|
      file.puts self.to_json
    end
  end

end