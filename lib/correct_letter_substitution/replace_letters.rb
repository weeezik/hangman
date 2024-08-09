def replace_letters (letter, display_word, positions)
  positions.each do |position|
    display_word[position] = letter
  end
  display_word
end