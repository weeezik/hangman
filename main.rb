
dictionary = File.new("google-10000-english-no-swears.txt", "r")
words = dictionary.readlines

words.each do |word|
  word.delete("\n")
end

words.filter! do |word|
  word.length > 5
end
words.filter! do |word|
  word.length < 12
end

puts words.sample