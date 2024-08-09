def determine_end_display (lives, secret_word)
  if lives == 0
    puts "\nYou ran out of lives 😖😖😖😖😖\n".colorize(:red)
    puts "The word was #{secret_word}\n"
  else
    puts "\nNice job! You win! 😁😁😁\n".colorize(:green).blink
  end
end