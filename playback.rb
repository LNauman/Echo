# Beth and Lindsay


def playback
  puts "What do you want to say?"
  print "> "
  input = gets.chomp

  if input == "Nothing!"
    puts "Ok, fine!"
  elsif input == "I have a lot to say"
    puts "I don't have time for that right now!"
  else
    puts "You said: #{input}"
  end
end

playback
