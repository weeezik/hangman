module Substitutable
  #correct substitution
  def identify_locations_of_letter(word, letter)
    location_and_letter = word.each_char.with_index.select do |char,idx|
      char == letter
    end
    location_array = location_and_letter.flatten!.select {|item| item.is_a?(Integer)}
    location_array
  end

  def replace_letters (letter, display_word, positions)
    positions.each do |position|
      display_word[position] = letter
    end
    display_word
  end

  def correct_letter_substitution (secret_word, guessed_letter, display_word)
    locations_of_letters = identify_locations_of_letter(secret_word, guessed_letter)
    replace_letters(guessed_letter, display_word, locations_of_letters)
  end

  #incorrect substitution
end