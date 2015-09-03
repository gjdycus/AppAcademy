require 'rspec'
require 'deck'

describe Deck do
  subject(:deck){Deck.new}

  describe "#initialize" do
    it "should initialize with 52 cards" do
      expect(deck.cards.length).to eq(52)
    end

    it "should have 13 of each suit" do
      expect(deck.cards.uniq).to eq(deck.cards)
    end
  end

  describe "#deal_cards" do
    subject(:deck) { Deck.new }

    it "should remove a given number of cards from the deck" do
      deck.deal_cards(3)

      expect(deck.cards.length).to eq(49)
    end

    it "should return a given number of cards from the deck" do
      chosen_cards = deck.cards[-3..-1].reverse

      expect(deck.deal_cards(3)).to eq(chosen_cards)
    end
  end

end
