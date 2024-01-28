# https://adventofcode.com/2023/day/1

calibrations = File.read("./input.txt").chomp.split("\n")

str_to_int_hash = {
  'zero'  => '0',
  'one'   => '1',
  'two'   => '2',
  'three' => '3',
  'four'  => '4',
  'five'  => '5',
  'six'   => '6',
  'seven' => '7',
  'eight' => '8',
  'nine'  => '9',
}

calculations = calibrations.map do |calibration|
  matches = calibration.scan(/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/).flatten
  numbers = matches.map { |match| str_to_int_hash[match] || match }
  (numbers.first + numbers.last).to_i
end

puts calculations.sum
