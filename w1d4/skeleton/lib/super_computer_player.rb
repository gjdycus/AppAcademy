require_relative 'tic_tac_toe_node'
require 'byebug'

class SuperComputerPlayer < ComputerPlayer
  def initialize
    @name = "Tandy 401"
  end

  def move(game, mark)
    game_node = TicTacToeNode.new(game.board, mark)
    game_node.children.each do |child|
      if child.winning_node?(mark)
        return child.prev_move_pos
      end
    end

    game_node.children.each do |child|
      if !child.losing_node?(mark)
        return child.prev_move_pos
      end
    end

    raise "Maybe you aren't so good at writing super computer players"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  supercp = SuperComputerPlayer.new
  hp = HumanPlayer.new("Garrett")

  TicTacToe.new(supercp, hp).run
end
