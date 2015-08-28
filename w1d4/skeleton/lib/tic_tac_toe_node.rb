require_relative 'tic_tac_toe'
require 'byebug'

class TicTacToeNode
  attr_reader :board
  attr_accessor :next_mover_mark, :prev_move_pos, :child_nodes

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    # @child_nodes = nil
  end

  def losing_node?(evaluator)
    if board.over?
      return false if board.tied?
      return (board.winner != evaluator)
    end
    if evaluator == next_mover_mark
      children.all? { |child| child.losing_node?(evaluator) }
    else
      children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
      if board.over?
        return (board.winner == evaluator)
      end
      if evaluator == next_mover_mark
        children.any? { |child| child.winning_node?(evaluator) }
      else
        children.all? { |child| child.winning_node?(evaluator) }
      end
  end

  def children
    generate_children# if child_nodes.nil?
    # child_nodes
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  private

  def generate_children
    child_nodes = []
    board.rows.each_with_index do |row, index|
      row.each_index do |col|
        position = [index, col]
        if board[position].nil?
          next_board = board.dup
          next_board[position] = next_mover_mark
          next_mark = (next_mover_mark == :x ? :o : :x)
          child_nodes << TicTacToeNode.new(next_board, next_mark, position)
        end
      end
    end
    child_nodes
  end
end
