# Beth and Lindsay


def playback
  puts "What do you want to say?"
  print "> "
  chatty = []
  input = gets.chomp

  if input == "Nothing!"
    puts "Ok, fine!"
  elsif input == "I have a lot to say"
      puts "OK let's hear it!"
      print "> "
      input = gets.chomp
      chatty << input
      while input != "done"
        print "> "
        input = gets.chomp
        chatty << input
      end
      chatty.pop
      for trans in chatty do
        puts "You said: #{trans}"
      end

 
#puts "I don't have time for that right now!"
  else
    puts "You said: #{input}"
  end
end

playback
