require 'rspec'
require 'hand'

describe Hand do
  subject(:pair_hand) { Hand.new(pair_deck) }
  subject(:two_pair_hand) { Hand.new(two_pair_deck) }
  subject(:royal_hand) { Hand.new(royal_deck) }

  let(:royal_deck) { double("royal_deck", deal_cards: [ace, king, queen,jack, ten]) }
  let(:pair_deck) { double("pair_deck", deal_cards: [ace, ace, two, three, four]) }
  let(:two_pair_deck) { double("two_pair_deck", deal_cards: [ace, ace, two, two, four]) }

  let(:ace) { double("ace", rank: :ace, value: 14, suit: :clubs) }
  let(:king) { double("king", rank: :king, value: 13, suit: :clubs) }
  let(:queen) { double("queen", rank: :queen, value: 12, suit: :clubs) }
  let(:jack) { double("jack", rank: :jack, value: 11, suit: :clubs) }
  let(:ten) { double("ten", rank: :ten, value: 10, suit: :clubs) }
  let(:two) { double("two", rank: :two) }
  let(:three) { double("three", rank: :three) }
  let(:four) { double("four", rank: :four) }

  describe "#initialize" do
    it "should initialize a hand with 5 cards" do
      expect(pair_hand.cards.length).to eq(5)
    end
  end

  describe "#pair?" do
    it "should return true if given a pair" do
      expect(pair_hand.pair?).to be true
    end
  end

  describe "#two_pair?" do
    it "should return true if given a two-pair" do
      expect(two_pair_hand.two_pair?).to be true
    end
  end

  describe "#straight?" do
    it "should return false if given a royal_flush" do
      expect(royal_hand.straight?).to be false
    end
  end

  describe "#flush?" do
    it "should return false if given a royal_flush" do
      expect(royal_hand.flush?).to be false
    end
  end

  describe "#straight_flush?" do
    it "should return false if given a royal_flush" do
      expect(royal_hand.straight_flush?).to be false
    end
  end

  describe "#royal_flush?" do
    it "should return true if given a royal_flush" do
      expect(royal_hand.royal_flush?).to be true
    end
  end
end
