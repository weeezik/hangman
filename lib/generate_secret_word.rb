def generate_secret_word(dictionary)
  words = dictionary.readlines
  clean_dictionary(words)
  secret_word_array = words.sample.chomp
  secret_word_array
end