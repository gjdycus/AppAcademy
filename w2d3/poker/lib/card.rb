class Card
  attr_reader :suit, :rank

  SUITS = {
    :clubs    => "♣",
    :diamonds => "♦",
    :hearts   => "♥",
    :spades   => "♠"
  }

  RANKS = {
    :two => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }

  VALUES = {
    :two => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 11,
    :queen => 12,
    :king  => 13,
    :ace   => 14
  }

  # def self.rand_card
  #   rank = RANKS.keys.sample
  #   suit = SUITS.keys.sample
  #   return Card.new(rank, suit)
  # end

  # card = Card.rand_card

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def to_s
    "#{RANKS[rank]}#{SUITS[suit]}"
  end

end
