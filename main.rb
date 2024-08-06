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

secret_word.length.times do #change this
    print "_ "
end
puts secret_word

require 'io/console'
guessed_letter = STDIN.getch.chomp

secret_word.each_char do |char|
  if char == guessed_letter
    puts true
  else
    puts false
  end
end