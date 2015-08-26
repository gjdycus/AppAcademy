require 'byebug'
require './Board'
require './Card'
require './HumanPlayer'
require './ComputerPlayer'

class Game
  attr_reader :board, :player

  def initialize(player)
    @player = player
    @board = Board.new
    @previous_guess = nil
  end

  def play
    puts "Let's get it started, #{player.name}"
    board.render
    until board.won?
      previous_guess = get_guess
      system("clear")

      player.receive_revealed_card(board.reveal(previous_guess))


      board.render

      guess = get_guess
      system("clear")
      player.receive_revealed_card(board.reveal(guess))
      board.render

      if board[*guess].value != board[*previous_guess].value
        board[*guess].hide
        board[*previous_guess].hide
        previous_guess = nil
      else
        puts "You got a match!"
      end

      sleep(1)

      system("clear")
      board.render
    end
    puts "You win! You're a winner no matter what anyone else says."
  end

  private
    attr_accessor :previous_guess

    def valid_guess?(guess)
      guess != previous_guess && guess.is_a?(Array) && guess.length == 2 && !board[*guess].state
    end

    def get_guess
      guess = player.make_guess
      until valid_guess?(guess)
        puts "Invalid guess. Try again."
        guess = player.make_guess
      end
      guess
    end
end

if __FILE__ == $PROGRAM_NAME
  # player1 = HumanPlayer.new("Walter")
  player1 = ComputerPlayer.new
  g = Game.new(player1)
  g.play
end
