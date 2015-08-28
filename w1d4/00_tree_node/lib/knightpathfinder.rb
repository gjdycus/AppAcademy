require_relative './00_tree_node.rb'

class KnightPathFinder
  def initialize(start_position)
    @start_position = start_position
    @visited_positions = [start_position]
  end

  def self.valid_moves(pos)
    x = pos[0]
    y = pos[1]
    potential_valid_moves = [
      [x+2, y+1],
      [x+2, y-1],
      [x-2, y+1],
      [x-2, y-1],
      [x+1, y-2],
      [x+1, y+2],
      [x-1, y+2],
      [x-1, y-2]
    ]
    potential_valid_moves.select do |move|
      move.all? { |val| val < 8 && val >= 0 }
    end
  end

  def new_move_positions(pos)
    new_positions = KnightPathFinder::valid_moves(pos).reject do |move|
      visited_positions.include?(move)
    end
    visited_positions.concat(new_positions)
    new_positions
  end

  def build_move_tree
    root_tree = PolyTreeNode.new(start_position)
    queue = [root_tree]
    until queue.empty?
      current_position = queue.shift
      next_positions = new_move_positions(current_position.value)
      next_positions.each do |pos|
        new_branch = PolyTreeNode.new(pos)
        current_position.add_child(new_branch)
        queue << new_branch
      end
    end
    @root_tree = root_tree
  end

  def find_path(end_pos)
    root_tree.bfs(end_pos).trace_path_back
  end

  def run(end_pos)
    root_tree || build_move_tree
    find_path(end_pos)
  end

  private
    attr_reader :start_position
    attr_accessor :visited_positions, :root_tree
end
