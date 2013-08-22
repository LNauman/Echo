word_counts = {
  "the" => 2, "brown" => 1, "fox" => 1,
  "jumped" => 1, "over" => 1, "lazy" => 1, "dog" => 1
}

word_counts.each do |word, count|
  puts "#{word} appeared #{count} time(s)."
end