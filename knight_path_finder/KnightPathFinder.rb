require_relative "PathNode.rb"

class KnightPathFinder

  SHIFT = [
    [1, -2],
    [2, -1],
    [2, 1],
    [1, 2],
    [-1, 2],
    [-2, 1],
    [-2, -1],
    [-1, -2]
  ]

  attr_reader :position, :root

  def initialize(position)
    @position = position
    @visited_positions = [position]
    @move_tree = build_move_tree(@position)
  end

  def find_path(end_pos)
    end_node = @root.bfs(end_pos)
    end_node.trace_path_back(@root)
  end

  def build_move_tree(start_pos)
    @root = PathNode.new(start_pos)
    nodes = [root]
    until nodes.empty?
      current_node = nodes.shift
      new_move_positions(current_node.value).each do |new_position|
        new_node = PathNode.new(new_position)
        new_node.parent = current_node
        nodes << new_node
      end
    end
    @root
  end

  def new_move_positions(pos)
    valid_moves = KnightPathFinder.valid_moves(pos)
    new_valid_moves = valid_moves.select do |move|
      !@visited_positions.include?(move)
    end
    @visited_positions.concat(new_valid_moves)
    new_valid_moves
  end

  def self.valid_moves(pos)
    SHIFT.map do |shift|
      [shift.first + pos.first, shift.last + pos.last]
    end.select do |pos|
      pos.all? { |num| num.between?(0, 7) }
    end
  end

end
