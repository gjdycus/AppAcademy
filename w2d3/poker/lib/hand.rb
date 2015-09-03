require_relative 'deck.rb'

class Hand
  HIERARCHY = [
    :pair?, :two_pair?, :three_of_a_kind?, :straight?, :flush?, :full_house?,
    :four_of_a_kind?, :straight_flush?, :royal_flush?
  ]

  attr_reader :cards, :deck

  def initialize(deck)
    @deck = deck
    @cards = deck.deal_cards(5)
  end

  def calculate_hand
    HIERARCHY.each_with_index do |combination, index|
      return index if hand.send(combination)
    end
  end

  def hand_ranks
    cards.map{ |card| card.rank }
  end


  def hand_suits
    cards.map{ |card| card.suit }
  end

  def hand_values
    cards.map{ |card| Card::VALUES[card.rank] }
  end

  def pair?
    counters = {}
    hand_ranks.each do |rank|
      if counters[rank].nil?
        counters[rank] = 1
      else
        counters[rank] += 1
      end
    end
    counters.values.include?(2) && !full_house? && !two_pair?
  end

  def two_pair?
    counters = {}
    hand_ranks.each do |rank|
      if counters[rank].nil?
        counters[rank] = 1
      else
        counters[rank] += 1
      end
    end
    counters.select { |key, value| value == 2 }.length == 2
  end

  def three_of_a_kind?
    counters = {}
    hand_ranks.each do |rank|
      if counters[rank].nil?
        counters[rank] = 1
      else
        counters[rank] += 1
      end
    end
    counters.values.include?(3) && !full_house?
  end

  def straight?
    values = hand_values.sort
    values.last - values.first == 4 && hand_suits.uniq.length > 1
  end

  def flush?
    values = hand_values.sort
    hand_suits.uniq.length == 1 && values.last - values.first != 4
  end

  def full_house?
    counters = {}
    hand_ranks.each do |rank|
      if counters[rank].nil?
        counters[rank] = 1
      else
        counters[rank] += 1
      end
    end
    counters.values.include?(3) && counters.values.include?(2)
  end

  def four_of_a_kind?
    counters = {}
    hand_ranks.each do |rank|
      if counters[rank].nil?
        counters[rank] = 1
      else
        counters[rank] += 1
      end
    end
    counters.select { |key, value| value == 4 }.length == 1
  end

  def straight_flush?
    values = hand_values.sort
    hand_suits.uniq.length == 1 && values.last - values.first == 4 && values.last != 14
  end

  def royal_flush?
    values = hand_values.sort
    hand_suits.uniq.length == 1 && values.last - values.first == 4 &&
     values.last == 14
  end
end
