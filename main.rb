def clean_dictionary (dictionary)
  dictionary.each do |word|
    word.delete("\n")
  end

  dictionary.filter! do |word|
    word.length > 5
  end
  dictionary.filter! do |word|
    word.length < 12
  end
end

dictionary = File.new("google-10000-english-no-swears.txt", "r")
words = dictionary.readlines
clean_dictionary(words)
secret_word = words.sample.chomp #outputs word that is to be used in hangman gameplay
p secret_word.chars.join(" ")

display_word_array = Array.new(secret_word.length, "_")
p display_word_array.join(" ")



require 'io/console'
guessed_letter = STDIN.getch.chomp

secret_word.each_char do |char|
  if char == guessed_letter
    guessed_letter.chomp
  else
    "_".chomp
  end
end


=begin
secret_hash = {}
index = 0
secret_word.each_char do |char|
  secret_hash[index] = char
  index+=1 
end
puts secret_hash

display_hash = {}
index = 0
secret_word.length.times do
  display_hash[index] = "_"
  index+=1
end
puts display_hash
=end