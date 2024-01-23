# https://adventofcode.com/2023/day/8
require './steps_calculator.rb'

directions = File.read("./directions.txt").chomp
nodes = File.read("./nodes.txt").chomp

puts StepsCalculator.calculate(directions, nodes)
