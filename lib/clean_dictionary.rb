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