require_relative 'correct_letter_substitution/identify_locations_of_letter'
require_relative 'correct_letter_substitution/replace_letters'

def correct_letter_substitution (secret_word, guessed_letter, display_word)
  locations_of_letters = identify_locations_of_letter(secret_word, guessed_letter)
  replace_letters(guessed_letter, display_word, locations_of_letters)
end