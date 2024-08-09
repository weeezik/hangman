def identify_locations_of_letter(word, letter)
  location_and_letter = word.each_char.with_index.select do |char,idx|
    char == letter
  end
  # location_array = location_and_letter.select {|item| item.is_a? String}
  location_array = location_and_letter.flatten!.select {|item| item.is_a?(Integer)}
  location_array
end