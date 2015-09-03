require_relative 'deck.rb'
require_relative 'player.rb'

class Game
  attr_accessor :deck, :money_pot, :players, :current_player

  def initialize
    @deck = Deck.new
    @money_pot = 0
    @players= []
    add_players
    @current_player = players.first
  end

  def add_players
    puts "how many players?"
    gets.chomp.to_i.times do |num|
      puts "what is player #{num+1} name?"
      players << Player.new(gets.chomp, deck)
    end
  end

  def money_pot(new_money)
    money_pot += new_money
  end

  def switch_cards
    num_of_cards = current_player.discard_own_cards.count
    current_player.hand.cards += deck.deal_cards(num_of_cards)
  end

  def play
    while true
      current_player.display_cards
      switch_cards
      current_player.display_cards
      sleep 5
      players.rotate!
    end
  end

end

game = Game.new
game.play
