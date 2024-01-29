# https://adventofcode.com/2023/day/2

file = File.read("./input.txt").chomp.split("\n")

matches = file.map do |match|
  game_array = match.split(": ")
  game_number = game_array[0].split(" ")[1].to_i
  draws = game_array[1].split("; ")
  rgb = draws.map { |draw| draw.split(", ") }.flatten

  color_hash = rgb.each_with_object(Hash.new) do |color_string, color_hash|
    color_array = color_string.split(" ")
    if color_hash[color_array[1]].nil? || color_hash[color_array[1]] < color_array[0].to_i
      color_hash[color_array[1]] = color_array[0].to_i
    end
  end
  [game_number, color_hash]
end

# possibilities = matches.select { |match| match[1]["red"] <= 12 && match[1]["green"] <= 13 && match[1]["blue"] <= 14 }
# puts possibilities.map { |possibility| possibility[0] }.sum

puts matches.map { |match| match[1]["red"] * match[1]["green"] * match[1]["blue"] }.sum
