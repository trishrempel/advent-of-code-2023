require 'debug'

class StepsCalculator
  class << self
    def calculate(directions, nodes)
      new(directions, nodes).calculate
    end
  end

  def initialize(directions, nodes)
    @directions = directions
    @nodes = nodes
  end

  def calculate
    count = 0
    current_nodes = parsed_nodes.keys.select { |k| k.end_with?("A") }
    endpoints_found = Array.new(current_nodes.size)

    parsed_directions.cycle do |direction|
      endpoints_found.each_index.select { |i| endpoints_found[i].nil? }.each do |i|
        endpoints_found[i] = count if endpoint?(current_nodes[i])
      end

      break if endpoints_found.all?

      current_nodes = find_next_nodes(current_nodes, direction)
      count += 1
    end

    endpoints_found.reduce(:lcm)
  end

  private

  def find_next_nodes(current_nodes, direction)
    current_nodes.map { |n| parsed_nodes[n][direction] }
  end

  def endpoint?(node)
    node.end_with?("Z")
  end

  def parsed_directions
    @parsed_directions ||= @directions.chars.map { |d| d == "L" ? 0 : 1 }
  end

  def parsed_nodes
    @parsed_nodes ||= @nodes.split("\n").each_with_object({}) do |v, h|
      v.split(" = ").tap do |k, v|
        h[k] = v.gsub(/\(|\)/, "").split(", ")
      end
    end
  end
end
