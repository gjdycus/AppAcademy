require_relative 'hand.rb'

class Player
  attr_accessor :money, :hand

  def initialize(name, deck)
    @hand = Hand.new(deck)
    @money = 100
  end

  def display_cards
    hand.cards.each_with_index { |card, index| puts "#{index}: #{card.to_s}" }
  end

  def select_cards
    puts "Choose which cards you want to discard"
    @unwanted_cards = gets.chomp.split(",").map(&:to_i)
    @unwanted_cards
  end

  def discard_own_cards
    discards = []
    select_cards.each do |index|
      discards << hand.cards[index]
    end

    discards.each do |card|
      hand.cards.delete(card)
    end
    @unwanted_cards
  end

  def make_move
    puts "Do you want to make a bet, fold, call, or check?"
    gets.chomp
  end

  def make_bet

  end

  def fold

  end

  def call

  end

  def check

  end
end
