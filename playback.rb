# Beth and Lindsay

# take t

def most_common(a)
  a.group_by do |e|
    e
  end.values.max_by(&:size).first
end

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
    msg = input.split(//)

    puts most_common(msg)

    # msg.sort!
    # msg.each do |i|
    #   puts "#{i}: #{msg.count(msg[0])}"
    # end




  end

end

playback
