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
    elsif input == "I have something prepared"
      puts "Ok, where can I find what you want to say?"
      print "> "
      input = gets.chomp

      while input != "speech.txt"
        puts "I couldn't find that file."
        puts "Where can I find what you want to say?"
          print "> "
            input = gets.chomp
      end
      rows = 0

      File.open(input) {|f| @count = f.read.count("\n")}
      File.open(input, 'r').each_line do |f|
        puts "You said: #{f}" if rows == 0
        rows += 1
        puts "Then, you said: #{f}" if rows < @count
        puts "Finally, you said: #{f}" if rows == @count


      end
      puts "Phew! Glad you got all #{@count} of those things off your chest!"

  else
    puts "You said: #{input}"
    msg = input.split(//)


    h = Hash.new(0)
     msg.each { | v | h.store(v, h[v]+1)}

    output = h.sort_by{ |k, v| v}
    puts "'#{output[-2][0]}' is the second most used character in what you said"
    puts "'#{output[-2][0]}' was used a total of #{output[-2][1]} times"


  end

end

playback
