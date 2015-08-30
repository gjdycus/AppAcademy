require_relative 'tile.rb'
require_relative 'board.rb'
require_relative 'player.rb'
require 'yaml'

class MinesweeperGame

  attr_reader :board, :player
  def initialize
    @player = Player.new
    @board = Board.new
  end

  def play
    until over?
      play_turn
    end

    board.reveal_all if lost?

    system("clear")
    board.display
    puts outcome_message
  end

  def play_turn
    system("clear")
    board.display
    input = player.make_guess

    if input == "save"
      save
    else
      action, pos = input
      x, y = pos
      board[x, y].send(action)
    end
  end

  def save
    puts "Enter desired file name"
    file_name = gets.chomp
    File.write("#{file_name}.yml", self.to_yaml)
    Kernel.abort("Good Bye.")
  end


  def over?
    lost? || won?
  end

  def lost?
    board.grid.each do |row|
      row.each do |tile|
        return true if tile.bomb? && tile.revealed?
      end
    end
    false
  end

  def won?
    board.grid.each do |row|
      row.each do |tile|
        if tile.bomb?
          return false unless tile.flagged?
        else
          return false unless tile.revealed?
        end
      end
    end

    true
  end

  def outcome_message
    lost? ? "KABOOM!!!" : "You won! Maybe you're not so unskilled after all!"
  end


end

if __FILE__ == $PROGRAM_NAME
  if ARGV[0]
    YAML.load_file(ARGV.shift).play
  else
    game = MinesweeperGame.new
    game.play
  end
end
