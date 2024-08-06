
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
puts words.sample #outputs word that is to be used in hangman gameplay