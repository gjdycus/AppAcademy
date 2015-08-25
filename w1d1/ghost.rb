class GhostGame
  require 'set'

  def initialize(*players)
    @fragment = ""
    @dictionary = Set.new(IO.readlines("ghost-dictionary.txt").map(&:chomp))
    @active_players = players
    @current_player = @active_players[0]
    @previous_player = @active_players[-1]
    @losses = {}
    @active_players.each { |player| @losses[player] = 0 }
  end

  def run
    until @active_players.length < 2 do
      until @losses.values.include?(5) do
        play_round
        display_standings
      end
      losing_player = @losses.select do |player, number|
        number == 5
      end.keys[0]
      puts "#{losing_player.name} loses!!"
      @active_players.delete(losing_player)
      @losses.delete(losing_player)
    end
    puts "#{@active_players[0].name} wins the game!!"
  end

  def display_standings
    ghost = "GHOST"
    @active_players.each do |player|
      puts "#{player.name} has #{ghost[0...@losses[player]]}"
    end
  end

  def play_round
    @fragment = ""
    until @dictionary.include?(@fragment) do
      take_turn(@current_player)
      next_player!
    end
    puts "\"#{@fragment.capitalize}\" was spelled."
    @losses[@previous_player] += 1
  end

  def next_player!
    index = @active_players.index(@current_player)
    @previous_player = @current_player
    @current_player = @active_players[(index+1) % @active_players.length]
  end

  def take_turn(player)
    puts "#{player.name}, it's your turn! Current string is #{@fragment}"
    guess = player.guess
    until valid_play?(guess)
      player.alert_invalid_guess
      guess = player.guess
    end
    @fragment += guess
  end

  def valid_play?(letter)
    new_str = @fragment + letter
    @dictionary.any? { |word| word[0...new_str.length] == new_str }
  end
end

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess
    puts "Guess a letter!"
    gets.chomp.downcase
  end

  def alert_invalid_guess
    puts "Invalid guess!"
  end
end
