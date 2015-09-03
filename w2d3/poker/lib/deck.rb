require_relative 'card.rb'


class Deck
  attr_reader :cards

  def initialize
    @cards = []
    generate_deck
  end

  def generate_deck
    Card::SUITS.keys.each do |suit|
      Card::RANKS.keys.each do |rank|
        cards << Card.new(suit, rank)
      end
    end
    cards.shuffle!
  end

  def deal_cards(num)
    dealed = []
    num.times do
      dealed << cards.pop
    end
    dealed
  end

end
